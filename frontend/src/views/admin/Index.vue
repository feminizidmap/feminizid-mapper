<template>
<div class="admin container-fluid">
  <div class="row">
    <h1>{{ $t('layout.adminArea') }}</h1>
    <hr>
  </div>
  <div class="row">
    <div class="col col-12 col-lg-3">
      <nav class="mb-5">
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
            <router-link :to="{ name: 'AdminCategoryList' }"
                         class="nav-link">{{ $t('layout.categories') }}</router-link>
          </li>
        </ul>

      </nav>
    </div>
    <div class="col col-12 col-lg-9">
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
