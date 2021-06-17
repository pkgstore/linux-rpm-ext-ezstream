#!/usr/bin/bash

(( EUID == 0 )) &&
  { echo >&2 "This script should not be run as root!"; exit 1; }

# -------------------------------------------------------------------------------------------------------------------- #
# Get options.
# -------------------------------------------------------------------------------------------------------------------- #

OPTIND=1

while getopts "d:p:h" opt; do
  case ${opt} in
    d)
      d_music="${OPTARG}"
      ;;
    p)
      f_playlist="${OPTARG}"
      ;;
    h|*)
      echo "-d '[music_dir]' -p '[playlist_file]'"
      exit 2
      ;;
  esac
done

shift $(( OPTIND - 1 ))

[[ -z "${d_music}" ]] || [[ -z "${f_playlist}" ]] && exit 1

# -------------------------------------------------------------------------------------------------------------------- #
# -----------------------------------------------------< SCRIPT >----------------------------------------------------- #
# -------------------------------------------------------------------------------------------------------------------- #

[[ ! -d "${d_music}" ]] && mkdir -p "${d_music}"

cd "${d_music}" && find "$( pwd )" -iname "*.mp3" | sort -R > "${f_playlist}"


# -------------------------------------------------------------------------------------------------------------------- #
# Exit.
# -------------------------------------------------------------------------------------------------------------------- #

exit 0