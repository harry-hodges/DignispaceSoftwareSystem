import { configureStore } from '@reduxjs/toolkit';
import { usersApi } from '../slices/apiSlice';
import tokenSLice from '../slices/tokenSlice';
import adminDashboardReducer from '../slices/adminDashboardSlice'
import userGroupReducer from '../slices/userGroupSlice';
import ManageQuestionsSlice from '../slices/ManageQuestionsSlice';
import userSlice from '../slices/userSlice';

export const store = configureStore({
  reducer: {
    token: tokenSLice,
    manageQuestions: ManageQuestionsSlice,
    [usersApi.reducerPath]: usersApi.reducer,
    adminDashboard: adminDashboardReducer,
    userGroup: userGroupReducer,
    user: userSlice,

  },
  middleware: getDefaultMiddleware =>
    getDefaultMiddleware().concat(usersApi.middleware)
});
