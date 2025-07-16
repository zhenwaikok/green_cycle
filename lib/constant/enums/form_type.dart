enum LoginFormFieldsEnum { email, password }

enum SignUpFormFieldsEnum {
  role,
  name,
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

enum ChangePassowrdFormFieldsEnum {
  currentPassword,
  newPassword,
  confirmNewPassword,
}

enum EditProfileFormFieldsEnum {
  role,
  name,
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
  itemDescription,
  category,
  quantity,
  conditionInfo,
}

enum AddEditAwarenessFormFieldsEnum { awarenessTitle, awarenessContent }

enum AddEditRewardFormFieldsEnum { rewardTitle, rewardDescription }

enum RejectCollectorFormFieldEnum { reason }
