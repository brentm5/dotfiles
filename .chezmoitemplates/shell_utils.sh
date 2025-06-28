# Utility functions to assist with scripts used to setup the environment here


# Internal method to write output in various formats
_line_() {
    local _alertType="${1}"
    local _message="${2}"

     if [[ ${_alertType} =~ ^(error|fatal) ]]; then
        _color="${bold}${red}"
    elif [ "${_alertType}" == "info" ]; then
        _color="${gray}"
    elif [ "${_alertType}" == "warning" ]; then
        _color="${yellow}"
    elif [ "${_alertType}" == "success" ]; then
        _color="${green}"
    elif [ "${_alertType}" == "header" ]; then
        _color="${bold}${white}${underline}"
    elif [ "${_alertType}" == "notice" ]; then
        _color="${bold}"
    else
        _color=""
    fi

    if [[ ${_alertType} == header ]]; then
        printf "\n✨ ${_color}%s${reset} ✨\n" "${_message}"
    else
        printf "${_color}[%7s] %s${reset}\n" "${_alertType}" "${_message}"
    fi

}

# External Methods for writing different types of output
error() { _line_ error "${1}" "${2:-}"; }
warning() { _line_ warning "${1}" "${2:-}"; }
notice() { _line_ notice "${1}" "${2:-}"; }
info() { _line_ info "${1}" "${2:-}"; }
success() { _line_ success "${1}" "${2:-}"; }
header() { _line_ header "${1}" "${2:-}"; }
