const baseEPosUrlAlpha = 'https://alpha.vtcpay.vn/mobileapis-appvtcepos';
const baseEposUrlBeta = 'https://beta.vtcpay.vn/mobileapis-appvtcepos';
const baseEposUrlProd = 'https://api.vtcpay.vn';

const baseVTCPayUrlAlpha = 'https://alpha.vtcpay.vn/mobileapis-appvtcpay';
const baseVTCPayUrlBeta = 'https://beta-mobile.vtcpay.vn';
const baseVTCPayUrlProd = 'https://api.vtcpay.vn';

const baseEposMediaAlpha = 'https://alpha.vtcpay.vn/eposmedia/resources';
const baseEposMediaBeta = 'https://beta.vtcpay.vn/eposmedia/resources';
const baseEposMediaProd = 'https://beta.vtcpay.vn/eposmedia/resources';

const vtcRequestSystemKey = 'vtc-request-system';
const vtcRequestSystemValue = '6d692e7d03b39ee92d142ee8cfc80b8c';
const loginQRServiceID = 100001;
const loginQRServiceKey = 'a31b868dc29b4e2b9015e055306f09e6';
const loginServiceId = 100000;
const loginServiceKey = '14ee22eaba297944c96afdbe5b16c65b';
const secretKeyIgnoreCheckDevice = 'd8a61deca2ee4027bfbc0131b1cc79de';

const channel = 'vtcpos_channel';

const encryptionKeyHive = 'encryprionKeyHive';

const nameBoxHive = 'vtc_epos_hive';

//Image definitions
const String defaultImage = 'assets/images/icon_app.png';
const String vtcpayConditionImg = 'assets/images/vtcpro_vcoin.png';
const String logoPay = 'assets/images/logo.png';

String isWillPop = '';

///Địa danh, vị trí máy người dùng
String locationName = 'Unknow';

const PRODUCT_MANGEMENT = 'PRODUCT_MANGEMENT';
const OPENCLOSESALE = 'OPENCLOSESALE';
const USER_MANAGEMENT = 'USER_MANAGEMENT';
const PERMISSION_MANAGEMENT = 'PERMISSION_MANAGEMENT';
const TABLE_MANAGEMENT = 'TABLE_MANAGEMENT';
const ORDER_MANAGEMENT = 'ORDER_MANAGEMENT';
const REPORT_MANAGEMENT = 'REPORT_MANAGEMENT';
const PAYMENT_ORDER = 'PAYMENT_ORDER';
const RECEIVE_NOTI_PAYMENT = 'RECEIVE_NOTI_PAYMENT';
const RECEIVE_NOTI_ORDER = 'RECEIVE_NOTI_ORDER';

String openedNotificationPoptoRouteName = '';

bool openedWhenAppIsKilled = false;

const requestTimeout = Duration(seconds: 30);

///Dùng để xác định kích cỡ màn hình
int factoryScale = 2;

const String telSupport = '19001530';

// IOS VERSION
int iOSVERSION = 1;

DateTime preBackPress = DateTime.now();

int appIsReviewVersionMode = 0;
