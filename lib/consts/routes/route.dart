// ignore_for_file: prefer_const_constructors

import 'package:PassPort/screens/add%20service/add%20images/addImages.dart';
import 'package:PassPort/screens/add%20service/addServices.dart';
import 'package:PassPort/screens/add%20service/submit%20service/submitService.dart';
import 'package:PassPort/screens/admin/adminHome.dart';
import 'package:PassPort/screens/auth/createPassword/createPassword.dart';
import 'package:PassPort/screens/auth/registration/traveller/traveller_register.dart';
import 'package:PassPort/screens/auth/verifyCode/verifyCode.dart';
import 'package:PassPort/screens/clendar/clander.dart';
// import 'package:PassPort/screens/onBoarding/onboarding.dart';
import 'package:PassPort/screens/onBoarding/onboardingMain.dart';
import 'package:PassPort/screens/partner/landinHome/connectTecnicialSupport/connectTecnicialSupport.dart';
import 'package:PassPort/screens/partner/landinHome/notifiction/notificationPartner.dart';
import 'package:PassPort/screens/partner/landinHome/profilePartner/profilePartner.dart';
import 'package:PassPort/screens/partner/landinHome/showallGuests/showallGuests.dart';
import 'package:PassPort/screens/partner/mainHome/mainHome.dart';
import 'package:PassPort/screens/partner/profile/account%20and%20security/accountSecurity.dart';
import 'package:PassPort/screens/partner/profile/account%20and%20security/change%20password/changePassword.dart';
import 'package:PassPort/screens/partner/profile/account%20and%20security/delete%20account/deleteAccount.dart';
import 'package:PassPort/screens/partner/profile/help/FAQS/FAQS.dart';
import 'package:PassPort/screens/partner/profile/help/contact%20us/contactsUs.dart';
import 'package:PassPort/screens/partner/profile/help/helpSupport.dart';
import 'package:PassPort/screens/partner/profile/languague/language.dart';
import 'package:PassPort/screens/partner/profile/notification/notificationSetting.dart';
import 'package:PassPort/screens/partner/profile/personal%20profile/edit%20company%20profile/edit/editCompantProfile.dart';
import 'package:PassPort/screens/partner/profile/personal%20profile/edit%20company%20profile/editCompanyProfilePlaceholder.dart';
import 'package:PassPort/screens/partner/profile/personal%20profile/edit%20profile/editProfile..dart';
import 'package:PassPort/screens/partner/profile/personal%20profile/personalProfile.dart';
import 'package:PassPort/screens/partner/profile/profits/profits.dart';
import 'package:PassPort/screens/partner/services/commentsandrating/commentsrating.dart';
import 'package:PassPort/screens/partner/services/detailsservices/addRoom.dart';
import 'package:PassPort/screens/partner/services/detailsservices/detailsservices.dart';
import 'package:PassPort/screens/partner/services/showimagesservices/showimageservices.dart';
import 'package:PassPort/screens/splash/splash.dart';
import 'package:PassPort/screens/traveller/booking/accomandation/detailsRooms/details_room_booking.dart';
import 'package:PassPort/screens/traveller/booking/accomandation/detailsbooking/detaialsbookingPending.dart';
import 'package:PassPort/screens/traveller/booking/accomandation/detailsbooking/detailsbookingCanceled.dart';
import 'package:PassPort/screens/traveller/booking/accomandation/detailsbooking/detailsbookingCompleted.dart';
import 'package:PassPort/screens/traveller/booking/accomandation/detailsbooking/detailsbookingUpcoming.dart';
import 'package:PassPort/screens/traveller/booking/activity/bookingActivity.dart';
import 'package:PassPort/screens/traveller/booking/activity/details/detailspending.dart';
import 'package:PassPort/screens/traveller/booking/booking.dart';
import 'package:PassPort/screens/traveller/booking/cancelReservation/cancelReservation.dart';
import 'package:PassPort/screens/traveller/booking/cancelReservation/confirm_cancel.dart';
import 'package:PassPort/screens/traveller/booking/reviews/review.dart';
import 'package:PassPort/screens/traveller/booking/trips/booking_trips/bookig_trips.dart';
import 'package:PassPort/screens/traveller/booking/trips/details/detailsBookingtrips.dart';
import 'package:PassPort/screens/traveller/favourites/detailsactivityfavourite.dart';
import 'package:PassPort/screens/traveller/favourites/detailsfavorite.dart';
import 'package:PassPort/screens/traveller/favourites/detailsproductfavourite.dart';
import 'package:PassPort/screens/traveller/favourites/detailstripsfavourite.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/Trips/followtrips.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/Trips/pendingbooking.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/Trips/tripBooking.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/Trips/trip_details.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/Trips/trips.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/accommodations/accommodations.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/accommodations/filter/filter.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/accommodations/report%20ad/reportAd.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/accommodations/room%20information/accommodation_details.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/accommodations/room%20information/available%20rooms/availableRooms.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/accommodations/room%20information/confirmation/confirmation.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/accommodations/room%20information/confirmation/pending.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/accommodations/room%20information/guest%20profile/guestProfile.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/accommodations/room%20information/view%20rooms/viewRooms.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/activities/activites.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/activities/activities%20details/activity_details.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/activities/activity%20booking/activityBooking.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/cart.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/checkout%20info/checkoutInfo.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/detailsProduct.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/payment/payment.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/payment/paymentsuccsful.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/product.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/product_details.dart';
import 'package:PassPort/screens/traveller/homeTravelling/notification/notificationsTraveller.dart';
import 'package:PassPort/screens/traveller/homeTravelling/search/search.dart';
import 'package:PassPort/screens/traveller/homeTravelling/stories/stories.dart';
import 'package:PassPort/screens/traveller/homeTravelling/stories/story%20info/storyInfo.dart';
import 'package:PassPort/screens/traveller/homeTravellingNavBar/homeTravellingNavBar.dart';
import 'package:PassPort/screens/traveller/profile/orders/detailsOrder.dart';
import 'package:PassPort/screens/traveller/profile/orders/orders.dart';
import 'package:PassPort/screens/traveller/profile/personal%20info/edit%20profile/travellerEditProfile.dart';
import 'package:PassPort/screens/traveller/profile/personal%20info/travellerPersonalInfo.dart';
import 'package:PassPort/version2_module/core/enums/user_type.dart';
import 'package:PassPort/version2_module/features/auth/forgot_password/view/change_password_screen.dart';
import 'package:PassPort/version2_module/features/auth/forgot_password/view/forgot_password.dart';
import 'package:PassPort/version2_module/features/auth/forgot_password/view/verify_code_screen.dart';
import 'package:PassPort/version2_module/features/auth/login/view/login_screen.dart';
import 'package:PassPort/version2_module/features/auth/privacy/privacy_policy_screen.dart';
import 'package:PassPort/version2_module/features/auth/signup/view/screens/signup_screen.dart';
import 'package:PassPort/version2_module/features/auth/terms/terms_conditions_screen.dart';
import 'package:PassPort/version2_module/features/home/view/screens/trips_list_page.dart';
import 'package:PassPort/version2_module/features/home/view/screens/unique_stays_list_page.dart';
import 'package:PassPort/version2_module/features/partener/presentation/screens/partner_bookings_screen.dart';
import 'package:PassPort/version2_module/features/partener/presentation/screens/partner_mobile_dashboard_screen.dart';
import 'package:PassPort/version2_module/features/partener/presentation/screens/partner_register_wrapper.dart';
import 'package:PassPort/version2_module/features/partener/presentation/screens/partner_services_screen.dart';
import 'package:PassPort/version2_module/features/partener/presentation/screens/service_details_screens/partner_activity_details_screen.dart';
import 'package:PassPort/version2_module/features/partener/presentation/screens/service_details_screens/partner_product_details_screen.dart';
import 'package:PassPort/version2_module/features/partener/presentation/screens/service_details_screens/partner_trip_details_screen.dart';
import 'package:PassPort/version2_module/features/partener/presentation/widgets/dynamic_service_form.dart';
import 'package:flutter/material.dart';

import '../../screens/partner/services/detailsservices/getroompartner.dart';
import '../../screens/traveller/booking/bookingHome.dart';
import '../../screens/traveller/homeTravelling/categories tabs/Trips/addTripe/addTripe.dart';

const String splash = 'splash';
const String home = 'home';
const String register = 'register';
const String partnerRegister = 'partnerRegister';
const String partnerRegisterV2 = 'partnerRegisterV2';
const String onBoarding = 'onBoarding';
const String onBoardingMain = "onBoardingMain";
const String login = "login";
const String forgotPassword = "forgotPassword";
const String verifyCode = "verifyCode";
const String verifyCodeV2 = "verifyCodeV2";
const String changePasswordV2 = "changePasswordV2";
const String createPassword = "createPassword";
const String landingHomeMain = "landingHomeMain";
const String notificationPartner = "notificationPartner";
const String connect = "connect";
const String viewAllGuests = "viewAllGuests";
const String addAccommodation = 'addAccommodation';
const String addImagesInAccommodation = 'addImagesInAccommodation';
const String submitService = 'submitService';
const String detailsServices = "detailsServices";
const String showImageServices = "showImageServices";
const String commentsAndRating = "commentsAndRating";
const String travellerRegister = 'travellerRegister';
const String termConditions = 'termConditions';
const String personalProfile = 'personalProfile';
const String editProfile = 'editProfile';
const String fatoraa = 'fatoraa';
const String editCompanyProfilePlaceHolder = 'editCompanyProfilePlaceHolder';
const String editCompanyProfile = 'editCompanyProfile';
const String profits = 'profits';
const String accountSecurity = 'accountSecurity';
const String privacy = "privacy";
const String changePassword = "changePassword";
const String deleteAccount = "deleteAccount";
const String notificationSetting = "notificationSettings";
const String language = "language";
const String help = "help";
// faqs terms concats
const String Faqs = "FAQS";
const String contactUs = "contactUs";
const String profilePartner = "profilePartner";
const String detailsBookingPending = "detailsBookingPending";
const String detailsBookingCompleted = "detailsBookingCompleted";
const String detailsBookingCanceled = "detailsBookingCanceled";
const String detailsBookingUpComing = "detailsBookingUpComing";
const String reviewBooking = "reviewBooking";

// Partner Service Details Routes
const String partnerProductDetails = "partnerProductDetails";
const String partnerActivityDetails = "partnerActivityDetails";
const String partnerTripDetails = "partnerTripDetails";

const String cancelReservation = "cancelReservation";

const String detailsFavorite = "detailsFavorite";

const String addTripe = "addTripe";
const String orderDetails = "orderDetails";
const String getRoomPartner = "getRoomPartner";

////////////////////////////////traveller////////////////////////////////////////////////
const String bookingHome = "BookingHome";
const String travellerNavBar = "travellerNavBar";
const String travellerNotification = "travellerNotification";
const String travellerSearch = "travellerSearch";
const String stories = "stories";
const String storyInfo = "storyInfo";
const String travellerPersonalInfo = "travellerPersonalInfo";
const String travellerEditProfile = "travellerEditProfile";
const String orders = "orders";
const String accommodation = "accommodations";
const String accommodationFilter = "accommodationsFilter";
const String roomInfo = "roomInfo";
const String viewRooms = "viewRooms";
const String availableRooms = 'availableRooms';
const String guestProfile = "guestProfile";
const String confirmation = "confirmation";
const String pending = "pending";
const String activities = "activities";
const String activitiesDetails = "activitiesDetails";
const String trips = "trips";
const String detailsTrips = "detailsTrips";
const String tripBooking = "tripBooking";
const String followTrips = "followTrips";
const String pendingBooking = "pendingBooking";
const String product = "product";
const String productDetails = "productDetails";
const String productDetails1 = "productDetails1";
const String payment = "payment";
const String paymentSusscful = "paymentSusscful";
const String cart = "cart";
const String checkoutInfo = "checkoutInfo";
const String activityBooking = "activityBooking";
const String reportAd = "reportAd";
const String detailsFavoriteProduct = "detailsFavoriteProduct";
const String detailsFavoriteActivity = "detailsFavoriteActivity";
const String detailsFavoriteTrips = "detailsFavoriteTrips";
const String booking = "booking";
const String bookingActivity = "bookingActivity";
const String detailsBookingActivity = "detailsBookingActivity";
const String detailsUpComingActivity = "detailsUpComingActivity";
const String detailsCompleteActivity = "detailsCompleteActivity";

const String bookingTrips = "bookingTrips";
const String bookingDetailsTrips = "bookingDetailsTrips";
const String confirmCancel = "confirmCancel";
const String homeAdmin = "homeAdmin";
const String calnder = "calnder";
const String addRoomDetails = "addRoomDetails";

const String getRoomDetails = "getRoomDetails";

//partner
const String partnerMobileDashboard = "partnerMobileDashboard";
const String partnerDashboard = "partnerDashboard";
const String partnerBookings = "partnerBookings";
const String partnerServiceRegistration = "partnerServiceRegistration";
const String partnerServiceDetails = "partnerServiceDetails";
const String partnerServiceEdit = "partnerServiceEdit";
const String partnerServiceAdd = "partnerServiceAdd";
const String partnerServiceList = "partnerServiceList";
const String dynamicForm = "dynamicForm";
const String tripsListPage = "tripsListPage";
const String uniqueStaysListPage = "uniqueStaysListPage";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case splash:
      return MaterialPageRoute(builder: (context) => const Splash());

    case register:
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    // case partnerRegister:
    //   return MaterialPageRoute(builder: (context) => const PartnerRegister());

    case calnder:
      return MaterialPageRoute(
          builder: (context) => CalendarPage(), settings: settings);

    case trips:
      return MaterialPageRoute(
          builder: (context) => const Trips(), settings: settings);
    case confirmCancel:
      return MaterialPageRoute(
          builder: (context) => const ConfirmCancel(), settings: settings);

    case pendingBooking:
      return MaterialPageRoute(builder: (context) => const PendingBooking());
    case paymentSusscful:
      return MaterialPageRoute(builder: (context) => const PaymentSuccessful());
    case followTrips:
      return MaterialPageRoute(builder: (context) => const FollowTrips());
    case bookingTrips:
      return MaterialPageRoute(
          builder: (context) => const BookingTrips(), settings: settings);
    case bookingDetailsTrips:
      return MaterialPageRoute(
          builder: (context) => const DetailsBookingTrips(),
          settings: settings);
    case bookingHome:
      return MaterialPageRoute(builder: (context) => BookingHome());
    case tripBooking:
      return MaterialPageRoute(
          builder: (context) => const TripBooking(), settings: settings);
    case productDetails:
      return MaterialPageRoute(
          builder: (context) => const ProductDetails(), settings: settings);
    case productDetails1:
      return MaterialPageRoute(
          builder: (context) => const ProductDetails1(), settings: settings);
    case payment:
      return MaterialPageRoute(builder: (context) => const Payment());

    case product:
      return MaterialPageRoute(
          builder: (context) => const Products(), settings: settings);

    case detailsTrips:
      return MaterialPageRoute(
          builder: (context) => const DetailsTrips(), settings: settings);
    case cancelReservation:
      return MaterialPageRoute(
          builder: (context) => CancelReservation(), settings: settings);
    case reviewBooking:
      return MaterialPageRoute(
          builder: (context) => const ReviewBooking(), settings: settings);
    // case onBoarding:
    // return MaterialPageRoute(builder: (conte87u55xt) => const OnBoarding());
    case detailsBookingCompleted:
      return MaterialPageRoute(
          builder: (context) => const DetailsBookingCompleted(),
          settings: settings);
    case detailsBookingCanceled:
      return MaterialPageRoute(
          builder: (context) => const DetailsBookingCCanceled(),
          settings: settings);

    case detailsBookingUpComing:
      return MaterialPageRoute(
          builder: (context) => const DetailsBookingUpComing(),
          settings: settings);

    case detailsFavorite:
      return MaterialPageRoute(builder: (context) => DetailsFavorite());

    case detailsFavoriteProduct:
      return MaterialPageRoute(
          builder: (context) => DetailsProductFavourite(), settings: settings);

    case detailsFavoriteActivity:
      return MaterialPageRoute(
          builder: (context) => DetailsActivityFavourite(), settings: settings);

    case detailsFavoriteTrips:
      return MaterialPageRoute(
          builder: (context) => DetailsTripsFavourite(), settings: settings);

    case detailsBookingPending:
      return MaterialPageRoute(
          builder: (context) => const DetailsBookingPending(),
          settings: settings);

    case addTripe:
      return MaterialPageRoute(builder: (context) => const AddTripe());
    case onBoardingMain:
      return MaterialPageRoute(builder: (context) => OnBoardingMain());
    case login:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case landingHomeMain:
      return MaterialPageRoute(
          builder: (context) => MainHome(), settings: settings);

    case travellerRegister:
      return MaterialPageRoute(builder: (context) => const TravellerRegister());
    // case forgotPassword:
    //    return MaterialPageRoute(builder: (context) => const ForgotPassword());
    case forgotPassword:
      return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
    case verifyCode:
      return MaterialPageRoute(
          builder: (context) => const VerifyCode(), settings: settings);
    case verifyCodeV2:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => VerifyCodeScreen(email: args['email']),
        settings: settings,
      );
    case changePasswordV2:
      return MaterialPageRoute(
        builder: (context) => const ChangePasswordScreen(),
        settings: settings,
      );
    case createPassword:
      return MaterialPageRoute(
          builder: (context) => const CreatePassword(), settings: settings);
    case notificationPartner:
      return MaterialPageRoute(
          builder: (context) => NotificationLandingPartner(),
          settings: settings);

    case termConditions:
      return MaterialPageRoute(
          builder: (context) => const TermsConditionsScreen());
    case connect:
      return MaterialPageRoute(
          builder: (context) => const ConnectTeamSupport());
    case viewAllGuests:
      return MaterialPageRoute(
          builder: (context) => const ShowAllGuests(), settings: settings);
    case detailsServices:
      return MaterialPageRoute(
          builder: (context) => const DetailsServices(), settings: settings);
    case showImageServices:
      return MaterialPageRoute(
          builder: (context) => const ShowImageServices(), settings: settings);
    case commentsAndRating:
      return MaterialPageRoute(
          builder: (context) => const CommentsAndRating(), settings: settings);

    case addAccommodation:
      return MaterialPageRoute(builder: (context) => const AddServices());
    case addImagesInAccommodation:
      return MaterialPageRoute(
          builder: (context) => const AddImages(), settings: settings);
    case submitService:
      return MaterialPageRoute(builder: (context) => const SubmitService());
    case personalProfile:
      return MaterialPageRoute(
          builder: (context) => const PersonalProfile(), settings: settings);
    case editProfile:
      return MaterialPageRoute(
          builder: (context) => const EditProfile(), settings: settings);
    case editCompanyProfilePlaceHolder:
      return MaterialPageRoute(
          builder: (context) => const EditCompanyProfilePlaceholder(),
          settings: settings);
    case editCompanyProfile:
      return MaterialPageRoute(
          builder: (context) => const EditCompanyProfile(), settings: settings);
    case profits:
      return MaterialPageRoute(builder: (context) => const Profits());
    case accountSecurity:
      return MaterialPageRoute(builder: (context) => const AccountSecurity());
    case privacy:
      return MaterialPageRoute(
          builder: (context) => const PrivacyPolicyScreen());
    case changePassword:
      return MaterialPageRoute(builder: (context) => const ChangePassword());
    case deleteAccount:
      return MaterialPageRoute(builder: (context) => const DeleteAccount());
    case notificationSetting:
      return MaterialPageRoute(
          builder: (context) => const NotificationSetting());
    case language:
      return MaterialPageRoute(builder: (context) => const Language());
    case help:
      return MaterialPageRoute(builder: (context) => const HelpSupport());
    case Faqs:
      return MaterialPageRoute(builder: (context) => const FAQS());
    case contactUs:
      return MaterialPageRoute(builder: (context) => const ContactsUs());

    case profilePartner:
      return MaterialPageRoute(
          builder: (context) => const ProfilePartner(), settings: settings);

    // Partner Service Details Routes
    case partnerProductDetails:
      return MaterialPageRoute(
          builder: (context) => const PartnerProductDetailsScreen(),
          settings: settings);

    case partnerActivityDetails:
      return MaterialPageRoute(
          builder: (context) => const PartnerActivityDetailsScreen(),
          settings: settings);

    case partnerTripDetails:
      return MaterialPageRoute(
          builder: (context) => const PartnerTripDetailsScreen(),
          settings: settings);

    /////////////////////traveller///////////////////////////
    case travellerNavBar:
      return MaterialPageRoute(
          builder: (context) => HomeTravellingNavBar(), settings: settings);
    // case travellerNavBar:
    //   return MaterialPageRoute(
    //       builder: (context) => const ExploreScreen(), settings: settings);
    case travellerNotification:
      //final List<RemoteMessage> messages = settings.arguments as List<RemoteMessage>;
      return MaterialPageRoute(
          builder: (context) => TravellerNotification(), settings: settings);
    case travellerSearch:
      return MaterialPageRoute(builder: (context) => const Serach());
    case stories:
      return MaterialPageRoute(
          builder: (context) => Stories(), settings: settings);
    case storyInfo:
      return MaterialPageRoute(
          builder: (context) => const StoryInfo(), settings: settings);
    case travellerPersonalInfo:
      return MaterialPageRoute(
          builder: (context) => const TravellerPersonalInfo(),
          settings: settings);
    case travellerEditProfile:
      return MaterialPageRoute(
          builder: (context) => const TravellerEditProfile(),
          settings: settings);
    case orders:
      return MaterialPageRoute(
          builder: (context) => Orders(), settings: settings);
    case detailsBookingActivity:
      return MaterialPageRoute(
          builder: (context) => const DetailsPendingActivity(),
          settings: settings);
    case accommodation:
      return MaterialPageRoute(
          builder: (context) => const Accommodations(), settings: settings);
    case accommodationFilter:
      return MaterialPageRoute(builder: (context) => const Filter());
    case roomInfo:
      return MaterialPageRoute(
          builder: (context) => const RoomInformation(), settings: settings);
    case viewRooms:
      return MaterialPageRoute(
          builder: (context) => const ViewRooms(), settings: settings);
    case availableRooms:
      return MaterialPageRoute(
          builder: (context) => const AvailableRooms(), settings: settings);
    case guestProfile:
      return MaterialPageRoute(
          builder: (context) => const GuestProfile(), settings: settings);
    case confirmation:
      return MaterialPageRoute(
          builder: (context) => const Confirmation(), settings: settings);
    case pending:
      return MaterialPageRoute(
          builder: (context) => const PendingRequest(), settings: settings);
    case activities:
      return MaterialPageRoute(
          builder: (context) => const Activities(), settings: settings);
    case activitiesDetails:
      return MaterialPageRoute(
          builder: (context) => const Details(), settings: settings);
    case cart:
      return MaterialPageRoute(
          builder: (context) => const Cart(), settings: settings);
    case checkoutInfo:
      return MaterialPageRoute(
          builder: (context) => const CheckoutInfo(), settings: settings);
    case activityBooking:
      return MaterialPageRoute(
          builder: (context) => const ActivityBooking(), settings: settings);
    case reportAd:
      return MaterialPageRoute(builder: (context) => const ReportAd());
    case booking:
      return MaterialPageRoute(
          builder: (context) => const Booking(), settings: settings);
    case bookingActivity:
      return MaterialPageRoute(
          builder: (context) => BookingActivity(), settings: settings);
    case orderDetails:
      return MaterialPageRoute(
          builder: (context) => OrderDetails(), settings: settings);
    case addRoomDetails:
      return MaterialPageRoute(
          builder: (context) => AddRoomDetails(), settings: settings);
    case getRoomDetails:
      return MaterialPageRoute(
          builder: (context) => ViewRoomDetailsBooking(), settings: settings);
    case getRoomPartner:
      return MaterialPageRoute(
          builder: (context) => GetRoomsPartner(), settings: settings);

    case homeAdmin:
      return MaterialPageRoute(
          builder: (context) => AdminHome(), settings: settings);

    case partnerRegisterV2:
      return MaterialPageRoute(
          builder: (context) => const PartnerRegisterWrapper(),
          settings: settings);

    case partnerMobileDashboard:
      return MaterialPageRoute(
          builder: (context) => const PartnerMobileDashboardScreen(),
          settings: settings);

    case partnerBookings:
      return MaterialPageRoute(
          builder: (context) => const PartnerBookingsScreen(),
          settings: settings);
    case partnerServiceList:
      return MaterialPageRoute(
          builder: (context) => const PartnerServicesScreen(),
          settings: settings);
    case dynamicForm:
      // Get partner type from arguments, default to accommodation
      final arguments = settings.arguments as Map<String, dynamic>?;
      final partnerType =
          arguments?['partnerType'] ?? UserType.accommodation.partnerTypeKey;

      return MaterialPageRoute(
          builder: (context) => DynamicServiceForm(
                partnerType: partnerType,
                onFormSubmit: (formData) {
                  // Handle form submission
                },
              ),
          settings: settings);

    case tripsListPage:
      final arguments = settings.arguments as Map<String, dynamic>?;
      final trips = arguments?['trips'] ?? [];
      return MaterialPageRoute(
          builder: (context) => TripsListPage(trips: trips),
          settings: settings);

    case uniqueStaysListPage:
      final arguments = settings.arguments as Map<String, dynamic>?;
      final uniqueStays = arguments?['uniqueStays'] ?? [];
      return MaterialPageRoute(
          builder: (context) => UniqueStaysListPage(uniqueStays: uniqueStays),
          settings: settings);

    // TODO: Add these routes when screens are implemented
    // case partnerServiceRegistration:
    //   return MaterialPageRoute(
    //       builder: (context) => const PartnerServiceRegistration(),
    //       settings: settings);
    // case partnerServiceDetails:
    //   return MaterialPageRoute(
    //       builder: (context) => const PartnerServiceDetails(),
    //       settings: settings);
    // case partnerServiceEdit:
    //   return MaterialPageRoute(
    //       builder: (context) => const PartnerServiceEdit(),
    //       settings: settings);
    // case partnerServiceAdd:
    //   return MaterialPageRoute(
    //       builder: (context) => const PartnerServiceAdd(),
    //       settings: settings);

    default:
      // return MaterialPageRoute(builder: (_) => const Splash());
      throw ('Route not found');
  }
}
