import RecordList from '@/views/records/List'
import RecordSingle from '@/views/records/Single'
import RecordForm from '@/views/records/Form'
import RecordStart from '@/views/records/Start'
import RecordEntity from '@/views/records/RecordEntityForm'
import RecordFinish from '@/views/records/Finish'
import RecordMeta from '@/views/records/Meta'
import RecordCrime from '@/views/records/Crime'
import RecordVictim from '@/views/records/Victim'
import RecordPerp from '@/views/records/Perpetrator'

export default {
  path: '/records/',
  name: 'records',
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
      component: RecordForm,
      children: [
        {
          path: '',
          name: 'RecordNewStart',
          component: RecordStart
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
        },
        {
          path: ':entityname',
          name: 'RecordNewEntity',
          component: RecordEntity
        },
        {
          path: 'finish',
          name: 'RecordNewFinish',
          component: RecordFinish
        }
      ]
    },
    {
      path: 'edit/:recordid',
      name: 'RecordEdit',
      component: RecordForm,
      children: [
        {
          path: '',
          name: 'RecordEditStart',
          component: RecordStart // TODO
        },
        {
          path: 'meta',
          name: 'RecordEditMeta',
          component: RecordMeta
        },
        {
          path: 'crime',
          name: 'RecordEditCrime',
          component: RecordCrime
        },
        {
          path: 'victim',
          name: 'RecordEditVictim',
          component: RecordVictim
        },
        {
          path: 'perpetrator',
          name: 'RecordEditPerpetrator',
          component: RecordPerp
        },
        {
          path: ':entityname',
          name: 'RecordEditEntity',
          component: RecordEntity
        },
        {
          path: 'finish',
          name: 'RecordEditFinish',
          component: RecordFinish
        }
      ]
    },
    {
      path: ':recordid',
      name: 'RecordSingle',
      component: RecordSingle
    }
  ]
}
