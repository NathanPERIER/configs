#!/bin/bash

OBSIDIAN_FILE='Obsidian.AppImage'
if [[ -z "$OBSIDIAN_PATH" ]]; then
    OBSIDIAN_PATH="${HOME}/${OBSIDIAN_FILE}"
fi

if ! [[ -f "$OBSIDIAN_PATH" ]]; then
	echo "Obsidian execuable does not exist (${OBSIDIAN_PATH})"
	exit 1
elif ! [[ -x "$OBSIDIAN_PATH" ]]; then
	echo "Obsidian application is not executable (${OBSIDIAN_PATH})"
	exit 1
fi

SYNCTHING_SERVICE="syncthing@${USER}.service"

if systemctl is-active "$SYNCTHING_SERVICE" > /dev/null
then
	echo 'Syncthing is running'
else
	echo 'Syncthing not running, attempting to start it...'
	systemctl start "$SYNCTHING_SERVICE"
	if systemctl is-active "$SYNCTHING_SERVICE" > /dev/null
	then
		echo 'Syncthing started'
	else
		echo 'Syncthing failed starting. For more details, run :'
		echo
		echo "      systemctl status ${SYNCTHING_SERVICE}"
		exit 1
	fi
fi

exec "$OBSIDIAN_PATH"

