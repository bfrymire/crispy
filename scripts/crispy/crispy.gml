/**
 * @description Crispy is an automated unit testing framework built in GML for GameMaker Studio 2.3+
 * https://github.com/bfrymire/crispy
 * Copyright (c) 2020-2021 bfrymire
 */

#macro CRISPY_NAME "Crispy"
#macro CRISPY_VERSION "1.2.0"
#macro CRISPY_DATE "5/14/2021"
#macro CRISPY_RUN true
#macro CRISPY_DEBUG false
#macro CRISPY_VERBOSITY 2 // {0|1|2}
#macro CRISPY_TIME_PRECISION 6
#macro CRISPY_PASS_MSG_SILENT "."
#macro CRISPY_FAIL_MSG_SILENT "F"
#macro CRISPY_PASS_MSG_VERBOSE "ok"
#macro CRISPY_FAIL_MSG_VERBOSE "Fail"
#macro CRISPY_STRUCT_UNPACK_ALLOW_DUNDER false

show_debug_message("Using " + CRISPY_NAME + " automated unit testing framework version " + CRISPY_VERSION);
