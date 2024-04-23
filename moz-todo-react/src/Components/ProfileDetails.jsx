import { useSelector } from 'react-redux';
import '../App.css'
import imageSrc from '../assets/profilepic.png';
import NavBar from '../Components/NavBar'
import { formatToken, useGetCurentUserDetailsQuery } from '../slices/apiSlice';
import { getToken } from '../slices/tokenSlice';
import { Link } from 'react-router-dom';



function ProfileDetails() {
    const token = useSelector(getToken)
    const {data: userData, isError, isFetching: isAnswersFetching, isLoading: isAnswersLoading,
        isSuccess: isAnswersSuccess, isUninitialized: isAnswersUninitialized} = useGetCurentUserDetailsQuery(formatToken(token['payload']))
    if (typeof token === 'undefined' || token === null ||  !('payload' in token)){
        return(<h1>Page not Found</h1>)
        }
    else{
        console.log(userData)
        return (
            <>
                <NavBar/>
                <h1>Profile Page</h1>
                <div className="profile-container">
                    <img className="lg_account" src={userData['profile_image']} alt="User Profile Picture" width="300px"/>
                    <p><a href="https://gravatar.com/" target="_blank">Edit Profile Picture on Gravatar</a></p>
                    <div className="text-container">
                        <p>Name   : {userData['name']}</p>
                        <p>Email  : {userData['email']}</p>
                        <p>Role   : {userData['role']}</p>
                    </div>
                    <div className="btn-group">
            
                        <Link to="/resetPassword"><button>Reset Password</button></Link>

                    </div>
                </div>

            </>
        )
    }
}

export default ProfileDetails
