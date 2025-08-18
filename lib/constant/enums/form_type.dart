enum LoginFormFieldsEnum { email, password }

enum SignUpFormFieldsEnum {
  role,
  firstName,
  lastName,
  fullName,
  email,
  gender,
  phoneNum,
  password,
  confirmPassword,
  vehicleType,
  vehiclePlateNum,
  organizationName,
  facePhoto,
}

enum ChangePasswordFormFieldsEnum {
  currentPassword,
  newPassword,
  confirmNewPassword,
}

enum EditProfileFormFieldsEnum {
  role,
  firstName,
  lastName,
  fullName,
  email,
  gender,
  phoneNum,
  password,
  address,
  vehiclePlateNum,
  companyName,
  vehicleType,
}

enum CreateOrEditListingFormFieldsEnum {
  itemPhotos,
  name,
  description,
  price,
  condition,
  category,
}

enum RequestForPickupFormFieldsEnum {
  remarks,
  pickupDate,
  itemPhotos,
  itemDescription,
  category,
  quantity,
  conditionInfo,
}

enum AddEditAwarenessFormFieldsEnum {
  awarenessTitle,
  awarenessContent,
  awarenessPhoto,
}

enum AddEditRewardFormFieldsEnum {
  rewardPhoto,
  rewardTitle,
  rewardDescription,
  rewardExpiryDate,
}

enum RejectCollectorFormFieldEnum { reason }

enum AddEditAddressFormFieldsEnum {
  address1,
  address2,
  city,
  state,
  postalCode,
}
