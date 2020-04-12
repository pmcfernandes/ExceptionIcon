import React from 'react';
import Header from '../header';

function MainPage({ children }) {
  return (
    <>
        <Header />
        <div className="container">
        <div className="row">
            <div className="col-lg-12">          
                { children }
            </div>
        </div>
    </div>
    </>
  );
}

export default MainPage;