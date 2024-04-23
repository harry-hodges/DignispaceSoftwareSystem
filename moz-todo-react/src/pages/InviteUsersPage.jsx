import React, { useEffect, useState } from 'react';
import { getToken } from '../slices/tokenSlice';
import { useDispatch, useSelector } from 'react-redux';
import { formatAddRole, formatToken, useAddRoleMutation, useCreateQuestionMutation, useDeleteQuestionMutation, useGetAssociatedUserGroupsQuery, useGetQuestionsQuery, useGetUserGroupQuery, useLazyGetQuestionsQuery } from '../slices/apiSlice';
import NavBar from '../Components/NavBar';
import TableComponent from '../Components/Table';
import CreateQuestion from '../Components/CreateQuestion';
import { apiCalledFalse, firstApiCalledTrue, getApiCalled, getFirstApiCalled, getInitTd, setInitialTd } from '../slices/ManageQuestionsSlice';

function InviteUsersPage() {  

  const [email, setEmail] = useState("")
  const [comfirmEmail, setComfirmEmail] = useState("")
  const [name, setName] = useState("")

  const token = useSelector(getToken)['payload']
  
  const {data} = useGetAssociatedUserGroupsQuery(formatToken(token))
  const [addRole, {status: addRoleStatus}] = useAddRoleMutation()

  let userGroup = []
  if (typeof data !== 'undefined')
  {
    if (data.length > 0){
        userGroup = data.filter( (group) => group['role'] === "ROLE_PATIENT")[0]
        console.log(userGroup)
    }
    
  }
 
    return(
        <>
            <NavBar />
            
            <div className="container">
                <div className="loginForm">
                  
                
                <h1>User Invite</h1>
                <form class="loginBoxes">
                <label>
                    Input email: <input name="emailInput" onChange={e => setEmail(e.target.value)}/>
                </label>
                <label>
                    Comfirm email: <input name="comfirmEmailInput" onChange={e => setComfirmEmail(e.target.value)}/>
                </label>
                <label>
                    Input name: <input name="nameInput" onChange={e => setName(e.target.value)}/>
                </label>

                <button onClick={(() => {
                    if (email === comfirmEmail){
                        addRole({"token": formatToken(token), "body": formatAddRole(email, name, userGroup['user_group_id'])})
                    }
                   })}>
                    Invite</button></form></div>
            </div>
        </>
    )

    }


export default InviteUsersPage;
