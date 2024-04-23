import React, { useState } from 'react';
import NavBar from '../Components/NavBar';

function UnathourisedPage() {  
    return (
        <div>
            <NavBar />
            <h1>Not authorised to access page</h1>
        </div>
    )
}

export default UnathourisedPage;
