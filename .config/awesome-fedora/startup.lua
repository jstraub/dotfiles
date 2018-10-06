local awful = require("awful")

function run_once(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
    end

    if not pname then
       pname = prg
    end

    if not arg_string then 
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
    else
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. " ".. arg_string .."' || (" .. prg .. " " .. arg_string .. ")",screen)
    end
end

-- run_once("xscreensaver","-no-splash")
-- run_once("pidgin",nil,nil,2)
-- run_once("wicd-client",nil,"/usr/bin/python2 -O /usr/share/wicd/gtk/wicd-client.py")

run_once("xmodmap ~/bin/swapEsc.xmod")
run_once("nm-applet")
run_once("atStartup")
run_once("kredentials")
run_once("nitrogen --restore")
run_once("~/bin/export_x_info.sh") -- so that cron can run offlineimap
run_once("synology-cloud-station",nil,"/home/jstraub/.CloudStation/app/bin/cloud-ui")
-- run_once("terminator","-T mutt -e mutt","/usr/bin/python /usr/bin/terminator")
-- run_once("terminator","-T gtd -e 'vim ~/notes/gtd.gtd'")
-- run_once("offlineimap","-u quiet","/usr/bin/python /usr/bin/offlineimap")
