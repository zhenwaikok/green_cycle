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
}

enum CreateListingFormFieldsEnum {
  name,
  description,
  price,
  condition,
  category,
}

enum EditListingFormFieldsEnum { name, description, price, condition, category }

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
