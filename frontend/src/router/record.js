import RecordList from '@/views/records/List'
import RecordSingle from '@/views/records/Single'
import RecordNewForm from '@/views/records/NewForm'
import RecordWizard from '@/views/records/Wizard'
import RecordFinish from '@/views/records/Finish'
import RecordMeta from '@/views/records/Meta'
import RecordCrime from '@/views/records/Crime'
import RecordVictim from '@/views/records/Victim'
import RecordPerp from '@/views/records/Perpetrator'

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
          path: 'finish',
          name: 'RecordNewFinish',
          component: RecordFinish
        },
        {
          path: 'meta',
          name: 'RecordNewMeta',
          component: RecordMeta
        },
        {
          path: 'crime',
          name: 'RecordNewCrime',
          component: RecordCrime
        },
        {
          path: 'victim',
          name: 'RecordNewVictim',
          component: RecordVictim
        },
        {
          path: 'perpetrator',
          name: 'RecordNewPerpetrator',
          component: RecordPerp
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
