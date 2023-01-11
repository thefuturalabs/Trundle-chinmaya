<nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex align-items-top flex-row">
<div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-start">
  <div class="me-3">
    <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-bs-toggle="minimize">
      <span class="icon-menu"></span>
    </button>
  </div>
  <div>
    <a class="navbar-brand brand-logo" href="dashboard.php">
    <h2>Trundle</h2>
    </a>
    <a class="navbar-brand brand-logo-mini" href="dashboard.php">
     
    </a>
  </div>
</div>
<div class="navbar-menu-wrapper d-flex align-items-top"> 
  <ul class="navbar-nav">
    <li class="nav-item font-weight-semibold d-none d-lg-block ms-0">
      <h1 class="welcome-text">welcome <span class="text-black fw-bold"></span></h1>
      <!-- <h3 class="welcome-sub-text">Your performance summary this week </h3> -->
    </li>
  </ul>
  <ul class="navbar-nav ms-auto">
 
  
    
    <li class="nav-item dropdown">
     
      <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list pb-0" aria-labelledby="notificationDropdown">
       
        <a class="dropdown-item preview-item py-3">
          <div class="preview-thumbnail">
            <i class="mdi mdi-alert m-auto text-primary"></i>
          </div>
          <div class="preview-item-content">
            <h6 class="preview-subject fw-normal text-dark mb-1">Application Error</h6>
            <p class="fw-light small-text mb-0"> Just now </p>
          </div>
        </a>
        <a class="dropdown-item preview-item py-3">
          <div class="preview-thumbnail">
            <i class="mdi mdi-settings m-auto text-primary"></i>
          </div>
          <div class="preview-item-content">
            <h6 class="preview-subject fw-normal text-dark mb-1">Settings</h6>
            <p class="fw-light small-text mb-0"> Private message </p>
          </div>
        </a>
        <a class="dropdown-item preview-item py-3">
          <div class="preview-thumbnail">
            <i class="mdi mdi-airballoon m-auto text-primary"></i>
          </div>
          <div class="preview-item-content">
            <h6 class="preview-subject fw-normal text-dark mb-1">New user registration</h6>
            <p class="fw-light small-text mb-0"> 2 days ago </p>
          </div>
        </a>
      </div>
    </li>
   
    <li class="nav-item dropdown d-none d-lg-block user-dropdown">
      <a class="nav-link" id="UserDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">
        <img class="img-xs rounded-circle" src="images/faces/face8.jpg" alt="Profile image"> </a>
      <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="UserDropdown">
    
        <a class="dropdown-item" href="logout.php" ><i class="dropdown-item-icon mdi mdi-power text-primary me-2"></i>Sign Out</a>
      </div>
    </li>
  </ul>
  <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-bs-toggle="offcanvas">
    <span class="mdi mdi-menu"></span>
  </button>
</div>
</nav>