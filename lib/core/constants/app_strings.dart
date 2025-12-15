
class AppStrings{
  ///Common Strings
  static const String space = " ";
  static const String loadingPleaseWait = "Loading...";
  static const String loadingCompleted = "Loading Completed";
  static const String save = "Save";

  /// App Name
  static const String appNameHi = "Hi";
  static const String appNameWay = "Way";
  static const String appNameGo = "Go";
  static const String appName = appNameHi + appNameWay + appNameGo;

  /// User authentication
  static const String signUp = "Sign Up";
  static const String signIn = "Sign In";
  static const String forgotPassword = "Forgot Password";
  static const String firstName = "First Name";
  static const String lastName = "Last Name";
  static const String email = "Email";
  static const String nic = "NIC";
  static const String phone = "Phone No";
  static const String password = "Password";
  static const String rePassword = "Re-Password";
  static const String dontHaveAccount = "Don’t have an account?";
  static const String here = " here";
  static const String backTo = "Back to";
  static const String questionMark = "?";

  static const String enterYour = "Enter your ";
  static const String cannotEmpty = " cannot be empty";
  static const String formatInvalid = " format is not valid";
  static const String firstNameCannotEmpty = firstName + cannotEmpty;
  static const String lastNameCannotEmpty = lastName + cannotEmpty;
  static const String nicCannotEmpty = nic + cannotEmpty;
  static const String phoneNoCannotEmpty = phone + cannotEmpty;
  static const String emailCannotEmpty = email + cannotEmpty;
  static const String passwordCannotEmpty = password + cannotEmpty;
  static const String emailFormatInvalid = email + formatInvalid;
  static const String phoneNoFormatInvalid = phone + formatInvalid;
  static const String nicFormatInvalid = nic + formatInvalid;

  static const String passwordCannotBeShort = "Password should be minimum 6 characters long";
  static const String passwordNotMatching = "Passwords not matching";

  ///Social Media button related strings
  static const String google = "Google";
  static const String facebook = "Facebook";
  static const String googleSvgIcon = '<svg viewBox="1.0 0.0 22.92 22.92" ><path transform="translate(1.0, 0.0)" d="M 22.6936149597168 9.214142799377441 L 21.77065277099609 9.214142799377441 L 21.77065277099609 9.166590690612793 L 11.45823860168457 9.166590690612793 L 11.45823860168457 13.74988651275635 L 17.93386268615723 13.74988651275635 C 16.98913192749023 16.41793632507324 14.45055770874023 18.33318138122559 11.45823860168457 18.33318138122559 C 7.661551475524902 18.33318138122559 4.583295345306396 15.25492572784424 4.583295345306396 11.45823860168457 C 4.583295345306396 7.661551475524902 7.661551475524902 4.583295345306396 11.45823860168457 4.583295345306396 C 13.21077632904053 4.583295345306396 14.80519008636475 5.244435787200928 16.01918983459473 6.324374675750732 L 19.26015281677246 3.083411931991577 C 17.21371269226074 1.176188230514526 14.47633838653564 0 11.45823860168457 0 C 5.130426406860352 0 0 5.130426406860352 0 11.45823860168457 C 0 17.78605079650879 5.130426406860352 22.91647720336914 11.45823860168457 22.91647720336914 C 17.78605079650879 22.91647720336914 22.91647720336914 17.78605079650879 22.91647720336914 11.45823860168457 C 22.91647720336914 10.68996334075928 22.83741569519043 9.940022468566895 22.6936149597168 9.214142799377441 Z" fill="#ffc107" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(2.32, 0.0)" d="M 0 6.125000953674316 L 3.764603137969971 8.885863304138184 C 4.78324031829834 6.363905429840088 7.250198841094971 4.583294868469238 10.13710117340088 4.583294868469238 C 11.88963890075684 4.583294868469238 13.48405265808105 5.244434833526611 14.69805240631104 6.324373722076416 L 17.93901443481445 3.083411693572998 C 15.89257335662842 1.176188111305237 13.15520095825195 0 10.13710117340088 0 C 5.735992908477783 0 1.919254422187805 2.484718799591064 0 6.125000953674316 Z" fill="#ff3d00" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(2.26, 13.78)" d="M 10.20069408416748 9.135653495788574 C 13.16035556793213 9.135653495788574 15.8496036529541 8.003005981445312 17.88286781311035 6.161093711853027 L 14.33654403686523 3.160181760787964 C 13.14749050140381 4.064460277557373 11.69453620910645 4.553541660308838 10.20069408416748 4.55235767364502 C 7.220407009124756 4.55235767364502 4.689855575561523 2.6520094871521 3.736530303955078 0 L 0 2.878881216049194 C 1.896337866783142 6.589632034301758 5.747450828552246 9.135653495788574 10.20069408416748 9.135653495788574 Z" fill="#4caf50" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(12.46, 9.17)" d="M 11.23537635803223 0.04755179211497307 L 10.31241607666016 0.04755179211497307 L 10.31241607666016 0 L 0 0 L 0 4.583295345306396 L 6.475625038146973 4.583295345306396 C 6.023715496063232 5.853105068206787 5.209692478179932 6.962699413299561 4.134132385253906 7.774986743927002 L 4.135851383209229 7.773841857910156 L 7.682177066802979 10.77475357055664 C 7.431241512298584 11.00277233123779 11.45823955535889 8.020766258239746 11.45823955535889 2.291647672653198 C 11.45823955535889 1.523372769355774 11.37917804718018 0.773431122303009 11.23537635803223 0.04755179211497307 Z" fill="#1976d2" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
  static const String facebookSvgIcon = '<svg viewBox="0.3 0.27 22.44 22.44" ><defs><linearGradient id="gradient" x1="0.500031" y1="0.970054" x2="0.500031" y2="0.0"><stop offset="0.0" stop-color="#ff0062e0"  /><stop offset="1.0" stop-color="#ff19afff"  /></linearGradient></defs><path transform="translate(0.3, 0.27)" d="M 9.369577407836914 22.32988739013672 C 4.039577960968018 21.3760986328125 0 16.77546882629395 0 11.22104930877686 C 0 5.049472332000732 5.049472808837891 0 11.22105026245117 0 C 17.39262962341309 0 22.44210624694824 5.049472332000732 22.44210624694824 11.22104930877686 C 22.44210624694824 16.77546882629395 18.40252304077148 21.3760986328125 13.07252502441406 22.32988739013672 L 12.45536518096924 21.8249397277832 L 9.986735343933105 21.8249397277832 L 9.369577407836914 22.32988739013672 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(6.93, 4.65)" d="M 8.976840972900391 9.986734390258789 L 9.481786727905273 6.844839572906494 L 6.508208274841309 6.844839572906494 L 6.508208274841309 4.656734466552734 C 6.508208274841309 3.759051322937012 6.844841003417969 3.085787773132324 8.191367149353027 3.085787773132324 L 9.650103569030762 3.085787773132324 L 9.650103569030762 0.2244201600551605 C 8.864629745483398 0.1122027561068535 7.966946125030518 0 7.181471347808838 0 C 4.600629806518555 0 2.805262804031372 1.570946097373962 2.805262804031372 4.376209735870361 L 2.805262804031372 6.844839572906494 L 0 6.844839572906494 L 0 9.986734390258789 L 2.805262804031372 9.986734390258789 L 2.805262804031372 17.8975715637207 C 3.422420024871826 18.00978851318359 4.039577484130859 18.06587600708008 4.656735897064209 18.06587600708008 C 5.273893356323242 18.06587600708008 5.89105224609375 18.009765625 6.508208274841309 17.8975715637207 L 6.508208274841309 9.986734390258789 L 8.976840972900391 9.986734390258789 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

  ///Validation Regex patterns
  static final RegExp newNicRegex = RegExp(r'^\d{12}$');
  static final RegExp oldNicRegex = RegExp(r'^\d{9}[vVxX]$');
  static final RegExp phoneRegex = RegExp(r'^(?:7[0-9]|11|2[1-7]|3[1-8]|4[157]|5[12457]|6[03567]|81|91)[0-9]{7}$');
  static final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  ///Home Page related strings
  static const String busBooking = "Bus Booking";
  static const String liveBusTracing = "Live Bus Tracing";
  static const String busSchedule = "Bus Schedule";
  static const String contactUs = "Contact Us";
  static const String aboutUs = "About Us";
  static const String activityHistory = "Activity History";
  static const String logout = "Logout";

  ///Bus Booking Page related strings
  static const String busTracingDetails = "Bus Tracking Details";
  static const String from = "From";
  static const String to = "To";
  static const String date = "Date";
  static const String time = "Time";
  static const String search = "Search";
  static const String seatCount = "Seat Count";
  static const String available = "Available";
  static const String booked = "Booked";
  static const String addNewBooking = "Add New Booking";
  static const String bookingHistory = "Booking History";
  static const String deleteBooking = "Delete Booking?";
  static const String deleteBookingConfirmation = "Are you sure you want to delete this booking? This action cannot be undone.";
  static const String deleteBookingActionYes = "Yes, Delete";
  static const String deleteBookingActionNo = "No, Keep";

  ///Bus Booking Details Page related strings
  static const String bookingDetails = "Booking Details";
  static const String busName = "Bus Name";
  static const String busNumber = "Bus Number";

///Bus Route Page related strings
  static const String busRoute = "Bus Schedule";
  static const String busRouteDetails = "Bus Schedule Details";
  static const String busScheduleDetailsAddEdit = "Add Edit Schedule Details";
  static const String busRouteName = "Bus Route Name";
  static const String busRouteNumber = "Bus Route Number";
  static const String busRouteDescription = "Bus Route Description";
  static const String addNewBusSchedule = "Add New Bus Schedule";
  static const String busScheduleHistory = "Bus Schedule History";
  static const String deleteBusSchedule = "Delete Bus Schedule?";
  static const String deleteBusScheduleConfirmation = "Are you sure you want to delete this bus Schedule? This action cannot be undone.";
  static const String deleteBusScheduleActionYes = "Yes, Delete";
  static const String deleteBusScheduleActionNo = "No, Keep";

}