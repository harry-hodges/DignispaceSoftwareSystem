import React, { useState } from 'react';
import { getToken } from '../slices/tokenSlice';
import { useSelector } from 'react-redux';
import { formatToken, useGetAssociatedUserGroupsQuery, useGetQuestionsQuery, useGetUsersQuery } from '../slices/apiSlice';
import NavBar from '../Components/NavBar';

function Dashboard() {  
  const token = useSelector(getToken)
  const {data: userGroups, isSuccess, isFetching, isLoading, isUninitialized} = useGetAssociatedUserGroupsQuery(formatToken(token['payload']))
  if (typeof token == 'undefined' || token == null || !('payload' in token)){
    return <h1>404 page not found</h1>
  }
  else if (isFetching || isLoading, isUninitialized){
    return <h1>Loading</h1>
  }
  else{
    console.log(userGroups)
    return(
        <NavBar />
    )
    
  }
}

export default Dashboard;
