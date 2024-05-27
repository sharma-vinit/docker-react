import React from "react";
import logo from "./logo.svg";
import "./App.css";

function App() {
  // Log the environment variable for debugging
  console.log("REACT_APP_IMAGE_TAG:", process.env.REACT_APP_IMAGE_TAG);

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
        <p>Current Image Tag: {process.env.REACT_APP_IMAGE_TAG}</p>
        <p>This is working!</p>
        <p>This is Awesome!</p>
      </header>
    </div>
  );
}

export default App;
