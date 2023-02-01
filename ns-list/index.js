const core = require("@actions/core");
const exec = require("@actions/exec");
const fs = require('fs');

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
    // skip "parallel"
    // todo: can I extract these inputNames from the action.yml?
    const inputNames = [
      "query", "query_namespace", "query_name", "src", "platform",
      "config_mod", "format", "parse_argument_groups"
    ]
    const booleanInputs = ["parse_argument_groups"]
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
      } else {
        return ["--" + argName, value];
      }
    })
    let args = ["ns", "list"].concat(inputArgs);

    // run command
    await exec.exec("viash", args, options);
    
    // set output for output_file
    const output_file = core.getInput("output_file")
    if (output_file) {
      fs.writeFile(output_file, myOutput, { flag: 'wx' }, err => {
        if (err) {throw err;}
      })
      core.setOutput("output_file", myOutput)
    }

    // pass output
    core.setOutput("output", myOutput);
  } catch (error) {
    core.setFailed(error.message);
  }
}

run();