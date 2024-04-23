import React, { useState } from 'react';
import '../App.css'
import { getToken } from '../slices/tokenSlice';
import { useSelector } from 'react-redux';
import { formatToken, useGetUsersQuery } from '../slices/apiSlice';
import NavBar from '../Components/NavBar';


function SuspensionPage() {
  const [users, setUsers] = useState([
    { id: 1, name: 'Wafa', is_suspended: false },
    { id: 2, name: 'Ifa', is_suspended: true },
    { id: 3, name: 'Arash', is_suspended: false },
  ]);



  const handleBlockUser = (userId) => {
    setUsers(prevUsers => prevUsers.map(user => {
      if (user.id === userId) {
        return { ...user, is_suspended: !user.is_suspended };
      }
      return user;
    }));
  };
  
  const token = useSelector(getToken)
  const {data: usersData, isSuccess, isFetching, isLoading, isUninitialized} = useGetUsersQuery(formatToken(token['payload']))
  if (typeof token == 'undefined' || token == null || !('payload' in token)){
    return <h1>404 page not found</h1>
  }
  else if (isFetching || isLoading, isUninitialized){
    return <h1>Loading</h1>
  }
  else{
    console.log(usersData)
    return (
      <div className="userSuspension">
        <NavBar />
        <h1>User Suspension</h1>
        <table className="suspensionTable">
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Suspended</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user.id}>
                <td>{user.id}</td>
                <td>{user.name}</td>
                <td>{user.is_suspended ? 'Yes' : 'No'}</td>
                <td>
                  <button className="blockButton" onClick={() => handleBlockUser(user.id)}>
                    {user.is_suspended ? 'Unblock' : 'Block'}
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  }
}

export default SuspensionPage;
