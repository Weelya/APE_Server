Ape.addEvent("init", function() {
	include("framework/mootools.js");
	include("framework/Http.js");
	include("framework/userslist.js");
	include("utils/utils.js");
	include("commands/proxy.js");
	include("commands/inlinepush.js");
	include("examples/nickname.js");
	include("examples/move.js");
	include("utils/checkTool.js"); //Just needed for the APE JSF diagnostic tool, once APE is installed you can remove it 
	//include("examples/ircserver.js");
	//include("framework/http_auth.js");
});

// Ape.registerCmd("foo", false, function(params, cmd) { return [800, "bar"]  });
// http://192.168.2.110:6969/?[{"cmd":"foo"}]
// [{"time":"1297979089","raw":"ERR","data":{"code":"800","value":"bar"}}]
