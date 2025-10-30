import React, { useState, useEffect, createRef } from 'react';
import { Link, useHistory } from 'react-router-dom';

import MainPage from '../../components/mainPage'
import auth from '../../services/auth';
import api from '../../services/api';

function Profile() {
  const formRef = createRef();
  const history = useHistory();
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');

  function handleSaveClick() {
      if (password !== '' && password !== confirmPassword) {
        alert("Password don't match. Please confirm if password is same and try again.");
      } else {
        formRef.current.addEventListener('submit', function (e) {
          e.preventDefault();
          e.stopPropagation();

          if (name === '' || email === '') {
              if (formRef.current != null) {
                  formRef.current.classList.add('was-validated');
              }
          } else {
              api.put('/profile', {
                  'name': name,
                  'email': email,
                  'password': password,
                  'confirmPassword': (password === '' ? '' : confirmPassword)
              }, {
                  headers: {
                      'Content-Type': 'application/json'
                  }
              }).then(function (response) {
                  if (response.data.__ajs && response.data.success) {
                      alert('Updated with success.');
                      history.push('/projects');
                  } else {
                      alert('An error is occurred, its not possible create project at this time.');
                  }
              });
          }
      }, false);
      }
  }

  useEffect(() => {
    if (!auth.isAuthorized()) {
      history.push('/');
    }

    api.get('/profile').then(function (response) {
      if (response.data.__ajs && response.data.success) {
        let result = response.data.result;

        setName(result.name);
        setEmail(result.email);
      }
    });
  }, [history]);

  return (
    <MainPage>
      <div className="card mb-3">
        <div className="card-header">Profile</div>
        <div className="card-body">
          <form ref={formRef} noValidate>
            <div className="row">
              <div className="col">
                <div className="form-group">
                  <label htmlFor="name">Name</label>
                  <input type="text" className="form-control" id="name" placeholder="Name" value={name} onChange={(e) => setName(e.target.value)} required />
                </div>
              </div>
              <div className="col">
                <div className="form-group">
                  <label htmlFor="email">Email</label>
                  <input type="email" className="form-control" id="email" placeholder="Email" value={email} onChange={(e) => setEmail(e.target.value)} required />
                </div>
              </div>
            </div>
            <div className="row">
              <div className="col">
                <div className="form-group">
                  <label htmlFor="password">Password</label>
                  <input type="password" className="form-control" id="password" onChange={(e) => setPassword(e.target.value)} />
                </div>
              </div>
              <div className="col">
                <div className="form-group">
                  <label htmlFor="confirmPassword">Confirm password</label>
                  <input type="password" className="form-control" id="confirmPassword" onChange={(e) => setConfirmPassword(e.target.value)} />
                </div>
              </div>
            </div>
            <div className="row">
              <div className="col-12 text-right">
                <button type="submit" className="btn btn-danger" onClick={() => handleSaveClick()}>Save</button>
                <Link className="btn btn-link" to="/projects">Cancel</Link>
              </div>
            </div>
          </form>
        </div>
      </div>
    </MainPage>
  );
}

export default Profile;
