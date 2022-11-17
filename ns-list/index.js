const core = require('@actions/core');
const github = require('@actions/github');
const exec = require('@actions/exec');

async function run() {
  try {
    const src = core.getInput('src');
    const query = core.getInput('query');

    let myOutput = '';
    let myError = '';

    const options = {};
    options.listeners = {
      stdout: (data) => {
        myOutput += data.toString();
      },
      stderr: (data) => {
        myError += data.toString();
      }
    };

    const args = ['ns', 'list'];
    if (typeof src !== 'undefined') {
      args += ['--src=' + src]
    }
    if (typeof query !== 'undefined') {
      args += ['--query=' + query]
    }

    await exec.exec('viash', args, options);
    
    core.setOutput("components_json", myOutput);

    // Get the JSON webhook payload for the event that triggered the workflow
    const payload = JSON.stringify(github.context.payload, undefined, 2)
    console.log(`The event payload: ${payload}`);
  } catch (error) {
    core.setFailed(error.message);
  }
}

run();