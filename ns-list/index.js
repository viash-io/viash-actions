const core = require("@actions/core");
const github = require("@actions/github");
const exec = require("@actions/exec");

async function run() {
  try {
    // set up listeners for 'ns list'
    let myOutput = "";
    let myError = "";

    const options = {};
    options.listeners = {
      stdout: (data) => {
        myOutput += data.toString();
      },
      stderr: (data) => {
        myError += data.toString();
      }
    };

    // fetch arguments for command
    // todo: can I extract these inputNames from the action.yml?
    const inputNames = [
      "query", "query_namespace", "query_name", "src", "platform", "parallel", 
      "config_mod", "format", "parse_argument_groups"
    ]
    const inputArgs = inputNames.flatMap(function(argName) {
      const value = core.getInput(argName)
      if (value == "") {
        return [];
      } else {
        return ["--" + argName, value];
      }
    })
    let args = ["ns", "list"].concat(inputArgs);

    // run command
    await exec.exec("viash", args, options);
    
    // pass output
    core.setOutput("output", myOutput);
  } catch (error) {
    core.setFailed(error.message);
  }
}

run();