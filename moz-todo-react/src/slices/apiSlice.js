import { createApi, fetchBaseQuery} from "@reduxjs/toolkit/query/react";

import { useSelector } from "react-redux";
import { getToken } from "./tokenSlice";
import '../../env.js';
import environment from "../../env.js";

export const usersApi = createApi({
    reducerPath: "usersApi",
    baseQuery: fetchBaseQuery({ baseUrl: environment.REACT_APP_API_URL}),
    // auth
    endpoints: (builder) => ({
        getCurentUserDetails: builder.query({
            query: (token) => ({
                url: 'auth',
                headers: token
            })
        }),
        login: builder.mutation({
            query: loginDetails => ({
                url: 'auth',
                method: 'POST',
                body: loginDetails
            }),
        }),
        confirmation: builder.mutation({
            query: object => ({
                url: 'confirmation',
                method: 'POST',
                body: {"email": object.email}
            }),
        }),
        getConfirmation: builder.query({
            query: (token) => ({
                url: 'confirmation',
                headers: token
            })
        }),
        logout: builder.mutation({
            query: token => ({
                url: 'auth',
                method: 'DELETE',
                headers: token
            }),
        }),

        // alerts
        getAlerts: builder.query({
            query: (token) => ({
                url: 'alerts',
                headers: token
            })
        }),
        editAlert: builder.mutation({
            query: (object) => ({
                url: `alerts/${object.alertId}`,
                method: 'PUT',
                headers: object.token,
                body: {"active":11}
            })
        }),

        // User groups and User roles
        getUserGroup: builder.query({
            query: (object) => ({
                url: `groups/${object.groupId}`,
                headers: object.token
            })
        }),
        getAssociatedUserGroups: builder.query({
            query: (token) => ({
                url: 'roles',
                headers: token
            })
        }),
        addRole: builder.mutation({
            query: object => ({
                url: 'roles',
                method: 'POST',
                headers: object.token,
                body: object.body
            }),
        }),
        deleteRole: builder.mutation({
            query: object => ({
                url: `roles${object.roleId}`,
                method: 'DELETE',
                headers: object.token,
                body: object.body
            }),
        }),
        createGroup: builder.mutation({
            query: object => ({
                url: 'groups',
                method: 'POST',
                headers: object.token,
                body: object.body
            }),
        }),

        // questions
        getQuestions: builder.query({
            query: (token) => ({
                url: 'questions',
                headers: token
            }),
        }),
        createQuestion: builder.mutation({
            query: (object) => ({
                url: 'questions',
                method: 'POST',
                headers: object.token,
                body: object.body
            }),
        }),
        deleteQuestion: builder.mutation({
            query: (object) => ({
                url: `questions/${object.questionId}`,
                method: 'DELETE',
                headers: object.token
            })
        }),

        // User
        getUsers: builder.query({
            query: (token) => ({
                url: 'users',
                headers: token
            })
        }),
        editUser: builder.mutation({
            query: (object) => ({
                url: `users/${object.userId}`,
                method: 'PUT',
                headers: object.token,
                body: object.body
            })
        }),
        createUser: builder.mutation({
            query: (object) => ({
                url: 'users',
                method: 'POST',
                headers: object.token,
                body: object.body
            }),
        }),

        // Potential edits
        getPotentialEdit: builder.query({
            query: (object) => ({
                url: `potential_edits/${object.questionId}`,
                headers: object.token
            })
        }),
        createPotentialEdit: builder.mutation({
            query: (object) => ({
                url: 'potential_edits',
                method: 'POST',
                headers: object.token,
                body: object.body
            }),
        }),
        acceptPotentialEdit: builder.mutation({
            query: (object) => ({
                url: `potential_edits/accept/${object.editId}`,
                method: 'POST',
                headers: object.token,
            }),
        }),
        deletePotentialEdit: builder.mutation({
            query: (object) => ({
                url: `potential_edits/${object.editId}`,
                method: 'DELETE',
                headers: object.token
            })
        }),

        // Answers
        getAnswers: builder.query({
            query: (object) => ({
                url: `answer/${object.answerId}`,
                headers: object.token
            })
        }),
        createAnswer: builder.mutation({
            query: (object) => ({
                url: 'answer',
                method: 'POST',
                headers: object.token,
                body: object.body
            }),
        }),
        editAnswer: builder.mutation({
            query: (object) => ({
                url: `answer/${object.answerId}`,
                method: 'PUT',
                headers: object.token,
                body: object.body
            })
        }),

        // Flags
        getAllActiveFlags: builder.query({
            query: (object) => ({
                url: 'flag',
                headers: object.token
            })
        }),
        editFlag: builder.mutation({
            query: (object) => ({
                url: `flag/${object.flagId}`,
                method: 'PUT',
                headers: object.token,
                body: object.body
            })
        }),
        createFlag: builder.mutation({
            query: (object) => ({
                url: 'flag',
                method: 'POST',
                headers: object.token,
                body: object.body
            }),
        }),

        // Preferences
        getAllPreferencesForCurrentUser: builder.query({
            query: (object) => ({
                url: 'preference',
                headers: object.token
            })
        }),
        editPreference: builder.mutation({
            query: (object) => ({
                url: `preference/${object.preferenceId}`,
                method: 'PUT',
                headers: object.token,
                body: object.body
            })
        }),
        createPreference: builder.mutation({
            query: (object) => ({
                url: 'preference',
                method: 'POST',
                headers: object.token,
                body: object.body
            }),
        }),
        // Emotional Support Request
        createEmotionalSupportRequest: builder.mutation({
            query: (token) => ({
                url: 'emotional_support_request',
                method: 'POST',
                headers: token,
            }),
        }),
        deleteEmotionalSupportRequest: builder.mutation({
            query: (object) => ({
                url: `emotional_support_request/${object.requestId}`,
                method: 'DELETE',
                headers: object.token
            })
        }),

        // Bubbles
        getBubblesForUserGroup: builder.query({
            query: (object) => ({
                url: `bubble/${object.id}`,
                headers: object.token
            })
        }),
        createBubble: builder.mutation({
            query: (object) => ({
                url: 'bubble',
                method: 'POST',
                headers: object.token,
                body: object.body
            }),
        }),
        editBubble: builder.mutation({
            query: (object) => ({
                url: `bubble/${object.bubbleId}`,
                method: 'PUT',
                headers: object.token,
                body: object.body
            })
        }),
        
    })
});

export function formatLogin(email, password){
    return {
        "email": email,
        "password": password
        }
}

export function formatEditUser(name, email, role, suspended, password){
    return {
        "name": name,
        "email": email,
        "role": role, 
        "suspended": suspended,
        "password": password
    }
}

export function formatToken(token){
    return {
        "JILLAUTH": token
    }
}

export function formatCreateQuestion(title, content, sensitivity){
    return {
        "contents": content,
        "sensitivity": sensitivity, 
        "title": title
    }
}

export function formatAddRole(email, name, user_group_id){
    return {
        "email": email,
        "name": name,
        "user_group_id": user_group_id
    }
}

export function formatDeleteRole(email, user_group_id){
    return {
        "email": email,
        "user_group_id": user_group_id
    }
}

export function formatCreateGroup(patient_email, name){
    return {
        "patient_email": patient_email,
        "name": name
    }
}

export function formatCreateUser(role, name, email){
    return {
        "role": role,
        "name": name,
        "email": email
    }
}

export function formatCreatePotentialEdit(id, accepted, editContents, answer_id){
    return {
        "id": id,
        "accepted": accepted,
        "editContents": editContents,
        "answer_id": answer_id
    }
}

export function formatCreateAnswer(question_id, user_group_id){
    return {
        "question_id": question_id,
        "user_group_id": user_group_id
    }
}

export function formatEditAnswer(contents, bubbles){
    return {
        "contents": contents,
        "bubbles": bubbles
    }
}

export function formatEditFlag(reason){
    return {
        "reason": reason
    }
}

export function formatCreateFlag(active, reason, answer_id){
    return {
        "active": active,
        "reason": reason,
        "answer_id": answer_id
    }
}

// Used for createPreference and editPreference
export function formatPreference(name, value){
    return {
        "name": name,
        "value": value
    }
}

// Used for createBubble and editBubble
export function formatBubble(name, user_group_id, users){
    return {
        "name": name,
        "user_group_id": user_group_id,
        "users": users
    }
}
export const token = (state) => state.data.Token;



export const {useLoginMutation, useGetQuestionsQuery, useGetUsersQuery, useGetAnswersQuery, useGetCurentUserDetailsQuery,
useGetAssociatedUserGroupsQuery, useGetAlertsQuery, useCreateQuestionMutation, useDeleteQuestionMutation, useEditUserMutation,
 useGetUserGroupQuery, useConfirmationMutation, useGetConfirmationQuery, useLogoutMutation, useEditAlertMutation,
useAddRoleMutation, useCreateGroupMutation, useDeleteRoleMutation, useCreateUserMutation, useAcceptPotentialEditMutation,
useCreatePotentialEditMutation, useDeletePotentialEditMutation, useGetPotentialEditQuery, useCreateAnswerMutation, useEditAnswerMutation,
useCreateFlagMutation, useEditFlagMutation, useGetAllActiveFlagsQuery, useCreatePreferenceMutation, useEditPreferenceMutation,
useGetAllPreferencesForCurrentUserQuery, useCreateEmotionalSupportRequestMutation, useDeleteEmotionalSupportRequestMutation,
useCreateBubbleMutation, useEditBubbleMutation, useGetBubblesForUserGroupQuery, useLazyGetCurentUserDetailsQuery,
useLazyGetQuestionsQuery} = usersApi