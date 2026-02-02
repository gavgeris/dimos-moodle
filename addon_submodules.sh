#! /bin/sh

# mods
git submodule add https://github.com/learnweb/moodle-mod_groupmembers plugins/mod/groupmembers
git submodule add https://github.com/PoetOS/moodle-mod_questionnaire plugins/mod/questionnaire
git submodule add https://github.com/moodleworkplace/moodle-mod_coursecertificate plugins/mod/coursecertificate

#blocks
git submodule add https://github.com/donhinkelman/moodle-block_sharing_cart plugins/blocks/sharing_cart
git submodule add https://github.com/jleyva/moodle-block_configurablereports/ plugins/blocks/configurable_reports


#filters
git submodule add https://github.com/michael-milette/moodle-filter_filtercodes plugins/filter/filtercodes
git submodule add https://github.com/justinhunt/moodle-filter_generico plugins/filter/generico

#tools
git submodule add https://github.com/moodleworkplace/moodle-tool_certificate plugins/admin/tool/certificate

#availability
#git submodule add https://github.com/ewallah/moodle-availability_coursecompleted availability/condition/coursecompleted
git submodule add https://github.com/moodle-an-hochschulen/moodle-availability_role availability/condition/role

#course formats
git submodule add https://github.com/WisdmLabs/moodle-format_remuiformat plugins/course/format/remuiformat

#locals
git submodule add https://gitlab.com/adapta/moodle-local_modcustomfields plugins/local/modcustomfields
git submodule add https://github.com/moodle-an-hochschulen/moodle-local_staticpage plugins/local/staticpage
git submodule add https://github.com/rwthanalytics/moodle-local_learning_analytics plugins/local/learning_analytics

#enrolment
git submodule add https://github.com/bobopinna/moodle-enrol_autoenrol plugins/enrol/autoenrol

