import AdminSystem from '@/views/admin/System'
import AdminUsersList from '@/views/admin/users/List'
import AdminUsersEdit from '@/views/admin/users/Edit'
import AdminUsersChangesList from '@/views/admin/users/changes/List'

import CodelistIndex from '@/views/admin/codelist/Index'
import CodelistList from '@/views/admin/codelist/List'
import CodelistSingle from '@/views/admin/codelist/Single'


export default {
  path: '/admin/',
  name: 'Admin',
  component: () => import(/* webpackChunkName: "admin" */ '@/views/admin/Index'),
  children: [
    {
      path: '',
      name: 'AdminSystem',
      component: AdminSystem
    },
    {
      path: 'users',
      name: 'AdminUsersList',
      component: AdminUsersList
    },
    {
      path: 'users/:id',
      name: 'UserEdit',
      component: AdminUsersEdit
    },
    {
      path: 'users/:id/changes',
      name: 'AdminUsersChangesList',
      component: AdminUsersChangesList
    },
    {
      path: 'codelists',
      name: 'AdminCodelist',
      component: CodelistIndex,
      children: [
        {
          path: '',
          name: 'AdminCodelistList',
          component: CodelistList
        },
        {
          path: ':codelistkey',
          name: 'CodelistSingle',
          component: CodelistSingle
        }
      ]
    },
  ]
}
