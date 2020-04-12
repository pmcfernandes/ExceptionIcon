import React from 'react';

import './styles.css';

function IssueDetail({ issue }) {
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
            <td>{issue.stackTrace}</td>
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
              <code>{issue.stackTrace}</code>
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
              <code>
                {
                  
                }
              </code>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}

export default IssueDetail;
