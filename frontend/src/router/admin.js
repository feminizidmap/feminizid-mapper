import AdminSystem from '@/views/admin/System'
import AdminUsersList from '@/views/admin/users/List'
import AdminUsersEdit from '@/views/admin/users/Edit'
import AdminUsersChangesList from '@/views/admin/users/changes/List'

import CategoryIndex from '@/views/admin/category/Index'
import CategoryList from '@/views/admin/category/List'

import AdminSchema from '@/views/admin/schema/Index'


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
      path: 'categories',
      name: 'AdminCategories',
      component: CategoryIndex,
      children: [
        {
          path: '',
          name: 'AdminCategoryList',
          component: CategoryList
        }
      ]
    },
    {
      path: 'schema',
      name: 'AdminSchema',
      component: AdminSchema
    }
  ]
}
