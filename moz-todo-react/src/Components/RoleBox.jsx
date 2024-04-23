import { useState } from 'react';
import '../App.css'
import { formatCreateQuestion, formatToken, useCreateQuestionMutation } from '../slices/apiSlice';
import { nanoid } from '@reduxjs/toolkit';

function RoleBox({ boxes }) {
    const imageStyle = {
        border: "1px solid #ddd",
        padding: "1.5px",
        width: "20px"}
    return (
        <div className='patientGroupMainPage'>
            <h1>{boxes[0][1]}</h1>
            {boxes.map((user) => (
                <div>
                    <h2>{user[0]}</h2>
                    <img src={user[2]} style={imageStyle}/>
                </div>
            ))}
        </div>
    );
}

export default RoleBox