import { useEffect, useState } from 'react'
import '../App.css'
import { formatLogin, formatToken, useGetCurentUserDetailsQuery, useLazyGetCurentUserDetailsQuery, useLoginMutation } from '../slices/apiSlice'
import { useNavigate } from 'react-router-dom';
import { addToken } from '../slices/tokenSlice';
import { useDispatch } from 'react-redux';
import { addEmail, addName, addRole, addUserId } from '../slices/userSlice';

function Login() {
  const [login, {data, isSuccess, isLoading, isUninitialized, isError}] = useLoginMutation()
  const [getUserDetails, {data: userData, isSuccess: isUserDetailsSuccess}] = useLazyGetCurentUserDetailsQuery()
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("")
  const navigate = useNavigate()
  const dispatch = useDispatch()
  const [hasToken, setHasToken] = useState(false)
  const [nextPage, setNextPage] = useState("/admin")
  const [t, setT] = useState("")

  if(isUserDetailsSuccess){
    dispatch(addUserId(userData['id']))
    dispatch(addRole(userData['role']))
    dispatch(addName(userData['name']))
    dispatch(addEmail(userData['email']))
    navigate(nextPage)
    
  }

  useEffect(() => {
    const params = new URLSearchParams(window.location.search)

    if (params.get("post_login") !== null && params.get("key") !== null && !hasToken){
        (async () => {
            const rawResponse = await fetch('https://dignispace.test.willjay.rocks/api/confirmation?token=' + params.get("key"), {
              method: 'GET',
            });
            const content = await rawResponse.json();
            console.log(content);
            console.log(content['Token']);
            

            if (content['Token'] !== null && !hasToken) {
              dispatch(addToken(content['Token']))
              setNextPage(params.get("post_login"))
              setT(content['Token'])
              setHasToken(true)
            }
          })();
    }
  }, [])
  
  useEffect(() => {
    if ((typeof data !== 'undefined' && 'Token' in data)){
      dispatch(addToken(data['Token']))
      getUserDetails(formatToken(data['Token']))
    }
  }, [isSuccess])
  
  useEffect(() => {
    console.log("______-")
    getUserDetails(formatToken(t))

  }, [hasToken])

  
  function handleSubmit() {
    if (email !== "" && password !== ""){
      login(formatLogin(email, password))
    }
  }

  if (isUninitialized || isError || (typeof data !== 'undefined' && 'Message' in data)){
      return (
          <>
              <div className="container">
                <div className="loginForm">
                  <h1>Login</h1>
                  <form onSubmit={handleSubmit} className="loginBoxes">
                      <label>
                          Email:
                          <input name="email" onChange={e => setEmail(e.target.value)}/>
                      </label>
          
                      <label>
                          Password:
                      <input type="password" onChange={e => setPassword(e.target.value)}/>
                      </label>
                      <button>Login</button>
                      <button onClick={(() => navigate("/forgotPassword"))}>Forgot Password</button>
                  </form>
                </div>
              </div>
          </>
      )
  }
  else if(isLoading){
      return (
        <>
          <h1>Loading...</h1>
        </>
      )
  }else if(isSuccess && isUserDetailsSuccess){
    console.log(userData)
    dispatch(addUserId(userData['id']))
    dispatch(addRole(userData['role']))
    dispatch(addName(userData['name']))
    dispatch(addEmail(email))
    navigate("/admin")
    
  }
  
  
}


export default Login

