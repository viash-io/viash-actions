const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {
    // set up listeners
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
    // skip "parallel"
    // todo: can I extract these inputNames from the action.yml?
    const inputNames = [
      "query", "query_namespace", "query_name", "src", "platform",
      "runner", "engine", "parallel", "config_mod", "target", "setup"
    ]
    const booleanInputs = ["parallel"]
    const multilineInputs = ["config_mod"]
    const inputArgs = inputNames.flatMap(function(argName) {
      const value = core.getInput(argName)
      if (value == "") {
        return [];
      } else if (booleanInputs.indexOf(argName) >= 0) {
        if (value.toLowerCase() == "true") {
          return ["--" + argName];
        } else {
          return [];
        }
      } else if (multilineInputs.indexOf(argName) >= 0) {
        const values = core.getMultilineInput(argName)
        return values.flatMap(function(value) {
          return ["--" + argName, value];
        })
      } else {
        return ["--" + argName, value];
      }
    })
    let args = ["ns", "build"].concat(inputArgs);

    // run command
    await exec.exec("viash", args, options);
    
    // pass output
    core.setOutput("output", myOutput);
  } catch (error) {
    core.setFailed(error.message);
  }
}

run();