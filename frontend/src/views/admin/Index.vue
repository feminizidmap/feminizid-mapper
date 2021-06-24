<template>
<div class="admin container-fluid">
  <div class="my-2 row">
    <h1>{{ $t('layout.adminArea') }}</h1>
    <hr>
  </div>
  <div class="row">
    <div class="col col-2">
      <nav class="">
        <ul class="nav nav-pills flex-column">
          <li class="nav-item">
            <router-link :to="{ name: 'AdminSystem' }" class="nav-link">{{ $t('admin.system')}}</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'AdminUsersList' }" class="nav-link">{{ $t('admin.users.list') }}</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'AdminSchema' }"
                         class="nav-link">{{ $t('layout.schema') }}</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'AdminCodelistList' }"
                         class="nav-link">{{ $t('layout.codelist') }}</router-link>
          </li>
        </ul>

      </nav>
    </div>
    <div class="col">
      <router-view></router-view>
    </div>
  </div>
</div>
</template>
<script>
export default {
  name: 'AdminIndexView'
}
</script>
