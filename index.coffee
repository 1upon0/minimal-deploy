console.log("Initializing...");
http = require('http')
exec = require('child_process').exec
config = require('./config');

http.createServer((req, res)->
  url=req.url;req=null;
  res.writeHead(200)
  res.setHeader("Content-Type", "text/plain; charset=utf-8");
  url=url.split("/",4);
  if((target = config[url[1]])?)
    res.write("Target Name: #{url[1]}\n");
    if(target.pass == url[2])
      res.write("Password Verified\n");
      if(url[3] ==  "status")
        res.write("Reporting Status as on: #{Date()}\n");
        res.write("Last Started: #{target.started}\n");
        res.write("Last Output: #{target.stopped}\n------\n#{target.output}");
        res.end();
        return
      else if(url[3] == "deploy")
        res.write("Deploying...")
        res.end();
        res=null;
        target.started=Date()
        target.output="Not Yet";
        target.stopped="Not Yet";
        exec(target.script,(err,stdout,stderr)->
          target.stopped=Date()
          target.output="ERROR:\n#{JSON.stringify(err)}\n-----\nSTDOUT:\n#{stdout}\n-----\nSTDERR:\n#{stderr}";
          );
        return
  else
    res.write("Invalid Target");
  res.end();
).listen(4000);
console.log("Ready");