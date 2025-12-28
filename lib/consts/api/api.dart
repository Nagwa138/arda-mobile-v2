class Api {
  static const String BASE_URL = 'https://sinoo.site';
  // static const String BASE_URL = 'https://asarsolution.runasp.net';

  static const String API_URL = BASE_URL + '/api/';

  ////partener
  static const String partener_register =
      API_URL + 'Accounts/Partener/register';
  String login = API_URL + 'Accounts/login';
  String register = API_URL + 'Accounts/Partener/register';
  String sendCode = API_URL + 'Accounts/sendVerificationCode';
  String verifyUser = API_URL + 'Accounts/verify';
  String createPassword = API_URL + 'Accounts/ForgetPassword';
  String accommondationsType = API_URL + 'AccomodationType/Types';
  String governments = API_URL + 'Governments';
  String applicationServices = API_URL + 'ApplicationServices';
  String getProfile = API_URL + 'PartenerInfo';
  String editProfile = API_URL + 'Users/Edit';
  String paymentOrNot =
      API_URL + 'Booking/ChangePaymentStatusToPaid?BookingId=';

  String editCompany = API_URL + 'PartenerInfo';

  String changePassword = API_URL + 'Accounts/ChangePassword';

  String addService = API_URL + 'Accomodation';

  String getServicesById = API_URL + 'Accomodation/GetServiceById?id=';

  String getServices = API_URL + 'Accomodation';

  // Partner-owned services listings (new)
  // Activities registered by the partner's company
  String getPartnerActivities = API_URL + 'Companies/GetPartnerActivities';
  // Products registered by the partner's company
  String getPartnerProducts = API_URL + 'Companies/GetPartnerProducts';
  // Trips registered by the partner's company
  String getPartnerTrips = API_URL + 'Companies/GetPartnerTrips';

  String amenities = API_URL + "Amenities";
  String specials = API_URL + "Specials";
  String uploadproductImages = API_URL + "ProductCategories/UploadImage";
  String uploadImage = API_URL + "Accomodation/Accomodation/UploadImage";

  /// mahmoud

  /// Traveller
  String registerTravelling = API_URL + 'Accounts/Travellerregister';
  String blog = API_URL + "Blogs/GetAllBlog/";
  String blogCategory = API_URL + "BlogCategories";

  String blogById = API_URL + "Blogs/Traveller/GetBlog?id=";
  String blogFav = API_URL + "Blogs/Traveller/Blog/AddFavorite?blogId=";
  String deleteFav = API_URL + "Blogs/Traveller/Blog/DeleteFavorite?Id=";
  String topRated = API_URL + "TopRated?topCount=5";

  String randomActivity = API_URL + "Activities/GetRandomActivities";

  String randomCamp = API_URL + "Accomodation/GetRandomCamps";
  String randomProduct = API_URL + "Product/GetRandomProducts";

  String randomHotel = API_URL + "Accomodation/GetRandomAccomodations";

  /// product
  String getAllProduct = API_URL + "Product/Product/GetAllProductCategory";

  String getAllProductById = API_URL + "Product/Product/GetAllById?id=";

  String getOneProductById = API_URL + "Product/GetProductDetails?id=";

  String addFavouriteOfProduct =
      API_URL + "Product/Traveller/Product/AddFavorite?id=";

  String deleteFavouriteOfProduct =
      API_URL + "Product/Traveller/Product/DeleteFavorite?Id=";
  String getAllOrder = API_URL + "Orders";
  String MadeOrder = API_URL + "Orders";

  String getDetailsOrder = API_URL + "Orders/GetOrderDetails?OrderId=";

  String madeOrderAgain = API_URL + "Orders/BookOrderAgain?OrderId=";

  /// Activity
  String getAllActivity = API_URL + "Activities/Activities/GetAll";
  String getActivityById = API_URL + "Activities/Activities/GetById?id=";

  String addFavouriteOfActivity =
      API_URL + "Activities/Traveller/Activities/AddFavorite?activitieId=";

  String deleteFavouriteOfActivity =
      API_URL + "Activities/Traveller/Activities/DeleteFavorite?Id=";

  /// trips
  String getAllTrips = API_URL + "Trips/Traveller/GetAllTrips";
  String getTripsById = API_URL + "Trips/Traveller/GetTripById/";

  String addTrips = API_URL + "Trips/Traveller/AddCustomTrip";

  String addFavouriteTrips =
      API_URL + "Trips/Traveller/Trip/AddFavorite?TripId=";
  String deleteFavouriteTrips =
      API_URL + "Trips/Traveller/Trip/DeleteFavorite?Id=";

  /// acommmomdating
  ///

  String getAllAccommodating = API_URL + "AccomodationType/Types";
  String getAllAccommodatingType =
      API_URL + "Accomodation/Traveller/GetAllAccomodation?id=";

  String getOneAccommodatingTypeById =
      API_URL + "Accomodation/GetServiceById?id=";
  String addFavouriteOfAccomandation =
      API_URL + "Accomodation/Traveller/Accomodation/AddFavorite?id=";

  String deleteFavouriteOfAccomandation =
      API_URL + "Accomodation/Traveller/Accomodation/DeleteFavorite?Id=";

  /// booking

  String getAllBooking = API_URL + "Booking/GetAllBooking?bookingStatus";
  String getBookingDetails = API_URL + "Booking/GetBookingById?id=";
  String createBookingTrip = API_URL + "Booking/BookTrip";
  String createBookingRoom = API_URL + "Booking/BookRoom";
  String createBookingActivity = API_URL + "Booking/BookActivity";
  String cancelBooking = API_URL + "Booking/CancelBooking?id=";
  String bookAgain = API_URL + "Booking/BookActivityAgain?BookingId=";
  String bookAgainTrips = API_URL + "Booking/BookTripAgain?BookingId=";
  String bookAgainRooms = API_URL + "Booking/BookRoomAgain?BookingId=";
  String getAvailableRoom = API_URL + "Rooms/GetAvailableRooms?id=";

  /// review
  ///

  String getReview = API_URL + "Reviews?id=";
  String addReviews = API_URL + "Reviews/AddReview";

  String getReviewAll = API_URL + "Reviews/GeAlltReview?ServiceId=";

  /// rooms

  String getAllRoom = API_URL + "Rooms/GetAvailableRooms?id=";

  /// user
  String userInformation = API_URL + "Users/PersonalData";
  String updateUserInformation = API_URL + "Users/Edit";
  String deleteAccount = API_URL + "Users/Delete?password=";

  String profits = API_URL + "PartenerInfo/PartnerProfits";

  String getAllFavourite = API_URL + "Favorites?favoritesType=";

  /// partner

  String getAllGuestPending = API_URL + "Booking/GetMyPendingRequests";
  String getAllGuestPendingCount =
      API_URL + "Booking/GetMyPendingRequests?count=";

  /// upcomming
  String getAllGuestUpcoming = API_URL + "Booking/GetMyUpCommingRequests";
  String getAllGuestUpcomingCount =
      API_URL + "Booking/GetMyUpCommingRequests?count=";

  /// complete

  String getAllGuestComplete = API_URL + "Booking/GetMyCompletedRequests";
  String getAllGuestCompleteCount =
      API_URL + "Booking/GetMyCompletedRequests?count=";

  /// cancel
  String getAllGuestCancel = API_URL + "Booking/GetMyCancelledRequests";
  String getAllGuestCancelCount =
      API_URL + "Booking/GetMyCancelledRequests?count=";

  ///
  String getGuestById = API_URL + "Booking/GetGetOnePendingRequests/";
}
