#!/bin/python
"""
    usage: backup-btrfs.py targetPath snapshotDirPath
    example: backup-btrfs.py /home /srv/backup/home
        creates a read-only snapshot of /home at /backup/home/2019-01-31

    Makes a snapshot of the target subvolume at snapshotPath/YYYY-MM-DD
    Also deletes old snapshots based on the policy described by snapshotPath/backup-conf.json

    backup-conf.json properties:
        dailyMax: (number) How many daily snapshots to keep.
        weeklMax: (number) How many weekly snapshots to keep.
        monthlMax: (number) How many monthly snapshots to keep.
        yearlyMax: (number) How many yearly snapshots to keep.
"""

import json
import os
import sys

import calendar
from datetime import date, datetime, timedelta
from subprocess import check_output

# test
# d = date.today() - timedelta(days=365*5)
# while d < date.today():
#     try:
#         status = check_output(['mkdir', os.path.join(sys.argv[2], d.strftime('%Y-%m-%d'))])
#     except Exception:
#         pass

#     d = d + timedelta(days=1)

def deleteSnapshot(path):
    print('Deleting snapshot {}'.format(path))
    try:
        return check_output(['btrfs', 'subvolume', 'delete', path], universal_newlines=True)
        # status = check_output(['rmdir', path])
    except Exception as e:
        print('Failed to delete snapshot {}'.format(path), file=sys.stderr)
        raise

def nextMonday(dt):
    return dt + timedelta(days=7 - dt.weekday())


def firstDayOfNextMonth(dt):
    return dt.replace(day=1) + timedelta(days=calendar.monthrange(dt.year, dt.month)[1])

def firstDayOfNextYear(dt):
    return dt.replace(day=1, month=1) + timedelta(days=365 + 1*calendar.isleap(dt.year))

targetPath = sys.argv[1]
snapshotPath = os.path.join(sys.argv[2], date.today().strftime('%Y-%m-%d'))

# create snapshot
try:
    if not os.path.exists(sys.argv[2]):
        os.makedirs(sys.argv[2])
    print('Creating snapshot {}'.format(snapshotPath))
    check_output(['btrfs', 'subvolume', 'snapshot', '-r', targetPath, snapshotPath], universal_newlines=True)
    # status = check_output(['mkdir', snapshotPath])
except Exception as e:
    print('Failed to create snapshot {}'.format(snapshotPath), file=sys.stderr)

# delete old snapshots
config = {}
configPath = os.path.join(sys.argv[2], 'backup-conf.json')
try:
    with open(configPath) as configFile:
        config = json.loads(configFile.read())
except FileNotFoundError as error:
    config = {}

# default settings
defaultConfig = {
    'dailyMax': 7,
    'weeklyMax': 4,
    'monthlyMax': 12,
    'yearlyMax': 2,
}

for key, value in defaultConfig.items():
    if key not in config:
        config[key] = value

dirNames = [file.name for file in os.scandir(sys.argv[2]) if file.is_dir()]
snapshotDates = []
for snapshot in dirNames:
    try:
        snapshotDates.append(datetime.strptime(snapshot, '%Y-%m-%d').date())
    except Exception as e:
        pass

snapshotDates.sort()

# categorize snapshots into temporal groups based on config
toKeep = set()
dailyDates = [snapshot for snapshot in snapshotDates if snapshot >= date.today() - timedelta(days=config['dailyMax'])]

if config['dailyMax'] > 0:
    toKeep.update(dailyDates[-config['dailyMax']:])

# first snapshot per week (starting on monday)
weeklyDates = [snapshot for snapshot in snapshotDates if snapshot >=  nextMonday(date.today()) - timedelta(weeks=config['weeklyMax'] + 1)]
firstDayOfWeeks = []
for i, snapshot in enumerate(weeklyDates):
    if i == 0 or snapshot >= nextMonday(firstDayOfWeeks[-1]):
        firstDayOfWeeks.append(snapshot)

if config['weeklyMax'] > 0:
    toKeep.update(firstDayOfWeeks[-config['weeklyMax']:])

# first snapshot per month
monthlyDates = snapshotDates # calculating the month cutoff is hard, just process all the dates
# monthlyDates = [snapshot for snapshot in snapshotDates if snapshot >= firstDayOfNextMonth(date.today()) - timedelta(weeks=4*(config['monthlyMax'] + 1))] # DOESN'T WORK! most months have more than 28 days in them
firstDayOfMonths = []
for i, snapshot in enumerate(monthlyDates):
    if i == 0 or snapshot >= firstDayOfNextMonth(firstDayOfMonths[-1]):
        firstDayOfMonths.append(snapshot)

if config['monthlyMax'] > 0:
    toKeep.update(firstDayOfMonths[-config['monthlyMax']:])

firstDayOfYears = []
for i, snapshot in enumerate(snapshotDates):
    if i == 0 or snapshot >= firstDayOfNextYear(firstDayOfYears[-1]):
        firstDayOfYears.append(snapshot)

if config['yearlyMax'] > 0:
    toKeep.update(firstDayOfYears[-config['yearlyMax']:])

for snapshot in snapshotDates:
    if snapshot not in toKeep:
        deleteSnapshot(os.path.join(sys.argv[2], snapshot.strftime('%Y-%m-%d')))
