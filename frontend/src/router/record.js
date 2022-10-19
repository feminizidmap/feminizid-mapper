import RecordList from '@/views/records/List'
import RecordSingle from '@/views/records/Single'
import RecordNewForm from '@/views/records/NewForm'
import RecordWizard from '@/views/records/Wizard'
import RecordEntityNewForm from '@/views/records/RecordEntityForm'
import RecordFinish from '@/views/records/Finish'

export default {
  path: '/records/',
  name: 'Records',
  component: () => import(/* webpackChunkName: "records" */ '@/views/RecordList.vue'),
  children: [
    {
      path: '',
      name: 'RecordList',
      component: RecordList
    },
    {
      path: 'new',
      name: 'RecordNew',
      component: RecordNewForm,
      children: [
        {
          path: '',
          name: 'RecordNewWizard',
          component: RecordWizard
        },
        {
          path: ':entityname',
          name: 'RecordNewEntity',
          component: RecordEntityNewForm
        },
        {
          path: 'finish',
          name: 'RecordNewFinish',
          component: RecordFinish
        }
      ]
    },
    // {
    //   path: 'edit/:recordid',
    //   name: 'RecordEdit',
    //   component: RecordForm,
    //   children: [
    //     {
    //       path: '',
    //       name: 'RecordEditMeta',
    //       component: RecordMeta
    //     }
    //   ]
    // },
    {
      path: ':recordid',
      name: 'RecordSingle',
      component: RecordSingle
    }
  ]
}
