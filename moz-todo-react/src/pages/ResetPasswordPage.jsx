import { useState } from 'react';
import '../App.css';
import { formatEditUser, formatToken, useEditUserMutation } from '../slices/apiSlice';
import { useNavigate } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux'; // Import `useSelector` to access state from Redux store
import { getEmail, getName, getRole, getUserId } from '../slices/userSlice';
import { getToken } from '../slices/tokenSlice';


function ResetPassword() {
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const navigate = useNavigate();
  const dispatch = useDispatch();
  

  // Retrieve authentication token from Redux store
  const token = useSelector(getToken)['payload'];
  const userId = useSelector(getUserId)['payload']
  const role = useSelector(getRole)['payload']
  const name = useSelector(getName)['payload']
  const email = useSelector(getEmail)['payload']

  // Use `useEditUserMutation` hook with authentication token
  const [editUser, { data: userData, isSuccess, isLoading, isError }] = useEditUserMutation();

  const handleSubmit = async (event) => {
    event.preventDefault();

    if (email !== '' && newPassword !== '' && newPassword === confirmPassword) {
      try {
        // Call `editUser` mutation with authentication token
        editUser({ userId: userId, token: formatToken(token), body: formatEditUser(name, email, role, false, newPassword) });
      } catch (error) {
        console.error('Password update error:', error); // Log catched error
      }
    } else {
      console.error('Validation error: Email or password fields are empty or passwords do not match.');
    }
  };

  if (userData) {
    navigate('/profile');
  }

  return (
    <div className="container">
      <div className="loginForm">
        <h1>Reset Password Page</h1>
        <form onSubmit={handleSubmit} className="loginBoxes">
          <label>
            New Password:
            <input 
              type="password"
              name="newPassword"
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)} 
              required
            />
          </label>
  
          <label>
            Confirm New Password:
            <input 
              type="password"
              name="confirmPassword"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)} 
              required
            />
          </label>
          <button type="submit" disabled={isLoading}>Submit</button>
        </form>
        <button onClick={(() => (navigate("/profile")))}>Back</button>
      </div>
      {isLoading && <h1>Loading...</h1>}
      {isError && <p>Error: Password update failed. Please try again.</p>}
    </div>
  );
}

export default ResetPassword;
