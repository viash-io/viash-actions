const core = require("@actions/core");
const exec = require("@actions/exec");
const fs = require('fs');
const path = require('path');

async function run() {
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
  options.silent = true;

  // set up workdir
  const workdir = core.getInput("project_directory");
  if (workdir) {
    options.cwd = workdir;
  }

  // fetch arguments for command
  // skip "parallel"
  // todo: can I extract these inputNames from the action.yml?
  const inputNames = [
    "query", "query_namespace", "query_name", "config", "src", "runner",
    "engine", "platform", "config_mod", "format", "parse_argument_groups"
  ]
  const booleanInputs = ["parse_argument_groups"]
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
  let args = ["ns", "list"].concat(inputArgs);

  try {
    await exec.exec("viash", args, options);
  } catch (error) {
    core.setFailed(myError);
    return;
  }

  // set output for output_file
  const output_file = core.getInput("output_file");
  const extension = "." + core.getInput("format");
  const to_write_to = output_file ? output_file : path.join(process.env.RUNNER_TEMP, Date.now().toString() + extension);
  fs.writeFile(to_write_to, myOutput, { flag: 'wx' }, err => {
    if (err) {throw err;}
  })
  core.setOutput("output_file", to_write_to)

  // pass output
  core.setOutput("output", myOutput);

  // parse json in myOutput
  let components = []
  if (core.getInput("format") == "json") {
    components = JSON.parse(myOutput);
  } else if (core.getInput("format") == "yaml") {
    const yaml = require('js-yaml');
    components = yaml.load(myOutput);
  }

  // turn into matrix
  const matrix = components.map(function(component) {
    const comp_name = component?.name ?? component?.functionality?.name
    const comp_namespace = component?.namespace ?? component?.functionality?.namespace
    const comp_fullname = comp_namespace ? comp_namespace + "/" + comp_name : comp_name
    const comp_config = component?.build_info?.config ?? component?.info?.config
    const comp_dir = comp_config ? path.dirname(comp_config) : undefined
    const resources = component?.resources ?? component?.functionality?.resources
    const comp_main_script_type = resources ? resources[0]?.type : undefined
    // todo: if component has a test_resource with a nextflow_script, get the entrypoint?
    return {
      name: comp_name,
      namespace: comp_namespace,
      full_name: comp_fullname,
      config: comp_config,
      dir: comp_dir,
      main_script_type: comp_main_script_type
    }
  })
  // return matrix as json
  let matrix_str;
  if (core.getInput("format") == "json") {
    matrix_str = JSON.stringify(matrix);
  } else if (core.getInput("format") == "yaml") {
    const yaml = require('js-yaml');
    matrix_str = yaml.dump(matrix);
  }
  core.setOutput("output_matrix", matrix_str);
}

run();