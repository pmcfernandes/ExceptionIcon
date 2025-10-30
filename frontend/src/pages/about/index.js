import React from 'react';

import MainPage from '../../components/mainPage'
import packageJson from '../../../package.json';

function About() {
  const programName = packageJson.name || 'ExceptionIcon';
  const programVersion = packageJson.version || '0.0.0';

  return (
    <MainPage>
      <h2>About</h2>
      <p><strong>Program:</strong> {programName} <small>v{programVersion}</small></p>
      <hr />
      <p><strong>Name:</strong> Pedro Fernandes</p>
      <p><strong>Email:</strong> <a href="mailto:pmcfernandes@gmail.com">pmcfernandes@gmail.com</a></p>
      <p><strong>Website:</strong> <a href="https://impedro.com" target="_blank" rel="noopener noreferrer">https://impedro.com</a></p>
    </MainPage>
  );
}

export default About;
