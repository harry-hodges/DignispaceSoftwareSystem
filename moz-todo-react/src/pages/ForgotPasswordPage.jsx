import { useState } from 'react';
import '../App.css';
import { formatEditUser, formatToken, useConfirmationMutation, useEditUserMutation } from '../slices/apiSlice';
import { useNavigate } from 'react-router-dom';

function ForgotPassword() {
  const [email, setEmail] = useState('');
  const navigate = useNavigate();

  
  const [editPassword, { data, isSuccess, isLoading, isError }] = useConfirmationMutation();

  const handleSubmit = async (event) => {
    event.preventDefault();
    editPassword({email: email})
    
  }

  if(isSuccess){
    navigate("/")
  }
  if(isLoading){
    return <h1>Loading...</h1>
  }
  if(isError){
    return <p>Error: Password update failed. Please try again.</p>
  }

  return (
    <div className="container">
      <div className="loginForm">
        <h1>Email</h1>
        <form onSubmit={handleSubmit} className="loginBoxes">
          <label>
            Please enter email:
            <input 
              name="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)} 
              required
            />
          </label>

          <button type="submit" disabled={isLoading}>Submit</button>
          <button onClick={(() => (navigate("/")))}>Back</button>
        </form>
      </div>
    </div>
  );
}

export default ForgotPassword;
