#!/bin/bash
set -e

echo "Creating data directories with correct permissions..."

# moodledata — www-data (UID 33) in moodlehq container
mkdir -p ./moodledata_data ./moodle_course_backups
chown -R 33:33 ./moodledata_data ./moodle_course_backups

# mariadb — UID 1001 in bitnami container
mkdir -p ./mariadb_data
chown -R 1001:1001 ./mariadb_data

echo "Done. You can now run: docker compose up -d"

# ---------------------------------------------------------------------------
# Plugin helper — skips if already cloned, shallow clone otherwise
# ---------------------------------------------------------------------------
clone_plugin() {
  local repo="$1"
  local dest="$2"
  if [ -d "$dest/.git" ]; then
    echo "  [skip] $dest already cloned"
  else
    echo "  [clone] $dest"
    mkdir -p "$(dirname "$dest")"
    git clone --depth 1 "$repo" "$dest"
  fi
}

echo ""
echo "Cloning Moodle plugins..."

# ---------------------------------------------------------------------------
# mod
# ---------------------------------------------------------------------------
clone_plugin https://github.com/learnweb/moodle-mod_groupmembers            plugins/mod/groupmembers
clone_plugin https://github.com/PoetOS/moodle-mod_questionnaire              plugins/mod/questionnaire
clone_plugin https://github.com/moodleworkplace/moodle-mod_coursecertificate plugins/mod/coursecertificate
clone_plugin https://github.com/danmarsden/moodle-mod_attendance             plugins/mod/attendance
# MISSING REPO — add URL: plugins/mod/attendanceregister
# MISSING REPO — add URL: plugins/mod/checklist
# MISSING REPO — add URL: plugins/mod/choicegroup
# MISSING REPO — add URL: plugins/mod/reengagement
# MISSING REPO — add URL: plugins/mod/zoom

# ---------------------------------------------------------------------------
# blocks
# ---------------------------------------------------------------------------
clone_plugin https://github.com/donhinkelman/moodle-block_sharing_cart      plugins/blocks/sharing_cart
clone_plugin https://github.com/jleyva/moodle-block_configurablereports     plugins/blocks/configurable_reports
clone_plugin https://github.com/jonof/moodle-block_completion_progress      plugins/blocks/completion_progress

# ---------------------------------------------------------------------------
# filter
# ---------------------------------------------------------------------------
clone_plugin https://github.com/michael-milette/moodle-filter_filtercodes   plugins/filter/filtercodes
clone_plugin https://github.com/justinhunt/moodle-filter_generico            plugins/filter/generico
# MISSING REPO — add URL: plugins/filter/mb2shortcodes

# ---------------------------------------------------------------------------
# tiny editor
# ---------------------------------------------------------------------------
clone_plugin https://github.com/reskit/moodle-tiny_c4l                      plugins/lib/editor/tiny/plugins/c4l

# ---------------------------------------------------------------------------
# auth
# ---------------------------------------------------------------------------
clone_plugin https://github.com/LafColITS/Moodle-auth_casattras             plugins/auth/casattras

# ---------------------------------------------------------------------------
# webservice
# ---------------------------------------------------------------------------
clone_plugin https://github.com/onbirdev/moodle-webservice_mcp             plugins/webservice/mcp

# ---------------------------------------------------------------------------
# admin tools
# ---------------------------------------------------------------------------
clone_plugin https://github.com/moodleworkplace/moodle-tool_certificate     plugins/admin/tool/certificate
# MISSING REPO — add URL: plugins/admin/tool/log/store/lanalytics

# ---------------------------------------------------------------------------
# availability
# ---------------------------------------------------------------------------
clone_plugin https://github.com/moodle-an-hochschulen/moodle-availability_role plugins/availability/condition/role
clone_plugin https://github.com/Lastent/percentage_availability             plugins/availability/condition/percentage

# ---------------------------------------------------------------------------
# local
# ---------------------------------------------------------------------------
clone_plugin https://gitlab.com/adapta/moodle-local_modcustomfields         plugins/local/modcustomfields
clone_plugin https://github.com/moodle-an-hochschulen/moodle-local_staticpage plugins/local/staticpage
# MISSING REPO — add URL: plugins/local/mb2builder
# MISSING REPO — add URL: plugins/local/mb2megamenu
# MISSING REPO — add URL: plugins/local/mb2reviews
# MISSING REPO — add URL: plugins/local/mb2coursenotes
# MISSING REPO — add URL: plugins/local/learning_analytics

# ---------------------------------------------------------------------------
# enrolment
# ---------------------------------------------------------------------------
clone_plugin https://github.com/bobopinna/moodle-enrol_autoenrol            plugins/enrol/autoenrol

echo ""
echo "All plugins cloned. You can now run: docker compose up -d"
