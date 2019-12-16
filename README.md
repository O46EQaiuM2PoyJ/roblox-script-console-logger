# roblox-script-console-logger
Logs script errors to my API

Approaches like pablospanish and th3ltgrounds that instantly and vocally ban someone for having a script error or cheat makes cheaters nervous, so lets put their minds at ease. These two scripts will silently log script errors to my list, located at  https://11.exploit.ws/console_logging/log.php, or https://11.exploit.ws/console_logging/view_nodup.php for no duplicate entries.
This way, discord webhooks are not spammed and people are not falsely auto-banned.

Base64 encoding is used to hide the contents from remotespy users, and the script and remotevent are named Spectate2 to further hide the true purpose.

Place Spectate2.lua in game.ReplicatedFirst, and place ScriptErrorLogHandler.lua in game.ServerScriptStorage

The logged errors are sent in batches every 15 seconds to prevent using up all your games http requests.

