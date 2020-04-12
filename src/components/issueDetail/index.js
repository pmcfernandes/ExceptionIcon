import React from 'react';

import './styles.css';

function IssueDetail({ issue }) {
  function getStackTrace1st(str) {
      if (typeof str !== 'undefined') {
        let line = str.split('\n');
        return line[0];
      } 

      return '';
  }

  return (
    <>
      <table className="table">
        <tbody>
          <tr>
            <td style={{ width: 160 }}><strong>Number</strong></td>
            <td>{issue.number}</td>
          </tr>
          <tr>
            <td><strong>Message</strong></td>
            <td>{issue.message}</td>
          </tr>
          <tr>
            <td><strong>Stack Trace</strong></td>
            <td>{getStackTrace1st(issue.stackTrace)}</td>
          </tr>
        </tbody>
      </table>

      <div className="accordion" id="accordionExample">
        <div className="card">
          <div className="card-header" id="headingOne">
            <h2 className="mb-0">
              <button className="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">Stack Trace</button>
            </h2>
          </div>
          <div id="collapseOne" className="collapse" aria-labelledby="headingOne" data-parent="#accordionExample">
            <div className="card-body">
              <p><strong>{issue.exceptionType}</strong>: {issue.message}</p>
              <pre>{issue.stackTrace}</pre>
            </div>
          </div>
        </div>
        <div className="card">
          <div className="card-header" id="headingTwo">
            <h2 className="mb-0">
              <button className="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">Environment</button>
            </h2>
          </div>
          <div id="collapseTwo" className="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
            <div className="card-body">
              <p><strong>Current Directory:</strong> {issue.currentDirectory}</p>
              <p><strong>Environment Variables</strong></p>
              <pre>
                {
                  Object.keys(issue.environmentVariables || {}).map(key => {
                    return (
                      <div><strong>{key}</strong>: {issue.environmentVariables[key]} </div>
                    )
                  })
                }
              </pre>
            </div>
          </div>
        </div>
        {(typeof issue.httpContext === 'undefined') ? '' :
          <div className="card">
            <div className="card-header" id="headingThree">
              <h2 className="mb-0">
                <button className="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">Http Context</button>
              </h2>
            </div>
            <div id="collapseThree" className="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
              <div className="card-body">
                <table className="table">
                  <tbody>
                    <tr>
                      <td style={{ width: 160 }}><strong>Host</strong></td>
                      <td>{issue.httpContext.host}</td>
                    </tr>
                    <tr>
                      <td><strong>Schema</strong></td>
                      <td>{issue.httpContext.schema}://</td>
                    </tr>
                    <tr hidden={issue.httpContext.method === ''}>
                      <td><strong>Method</strong></td>
                      <td>{issue.httpContext.method}</td>
                    </tr>
                    <tr>
                      <td><strong>Protocol</strong></td>
                      <td>{issue.httpContext.protocol}</td>
                    </tr>
                    <tr>
                      <td><strong>Path</strong></td>
                      <td>{issue.httpContext.path}</td>
                    </tr>
                    <tr hidden={issue.httpContext.queryString === ''}>
                      <td><strong>QueryString</strong></td>
                      <td>{issue.httpContext.queryString}</td>
                    </tr>
                    <tr hidden={Object.keys(issue.httpContext.query).length === 0 && issue.httpContext.query.constructor === Object}>
                      <td><strong>Query</strong></td>
                      <td>
                        <pre>
                        {
                          Object.keys(issue.httpContext.query || {}).map(key => {
                            return (
                              <div><strong>{key}</strong>: {issue.httpContext.query[key]} </div>
                            )
                          })
                        }
                        </pre>
                      </td>
                    </tr>
                    <tr hidden={Object.keys(issue.httpContext.cookies).length === 0 && issue.httpContext.cookies.constructor === Object}>
                      <td><strong>Cookies</strong></td>
                      <td>
                        <pre>
                        {
                          Object.keys(issue.httpContext.cookies || {}).map(key => {
                            return (
                              <div><strong>{key}</strong>: {issue.httpContext.cookies[key]} </div>
                            )
                          })
                        }  
                        </pre>
                      </td>
                    </tr>
                    <tr hidden={Object.keys(issue.httpContext.headers).length === 0 && issue.httpContext.headers.constructor === Object}>
                      <td><strong>Headers</strong></td>
                      <td>
                        <pre>
                        {
                          Object.keys(issue.httpContext.headers || {}).map(key => {
                            return (
                              <div><strong>{key}</strong>: {issue.httpContext.headers[key]} </div>
                            )
                          })
                        }  
                        </pre>
                      </td>
                    </tr>
                    <tr hidden={Object.keys(issue.httpContext.session).length === 0 && issue.httpContext.session.constructor === Object}> 
                      <td><strong>Session</strong></td>
                      <td>
                        <pre>
                        {
                          Object.keys(issue.httpContext.session || {}).map(key => {
                            return (
                              <div><strong>{key}</strong>: {issue.httpContext.session[key]} </div>
                            )
                          })
                        }  
                        </pre>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>}
      </div>
    </>
  );
}

export default IssueDetail;
