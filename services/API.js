const API_TOKEN = "e0c711d8-e3a7-11ef-9022-7e9c01851c55";
const SHOP_ID = 5617503;

const provinceSelect = document.getElementById("province");
const districtSelect = document.getElementById("district");
const wardSelect = document.getElementById("ward");
const shippingFeeInput = document.getElementById("priceShipping");
const addressDetailInput = document.getElementById("addressDetail");
const address = document.getElementById("address");
const paymentButton = document.getElementById("paymentButton");
const weightInput = document.getElementById("weight");

// Tải danh sách tỉnh/thành phố
async function loadProvinces() {
   const response = await fetch("https://online-gateway.ghn.vn/shiip/public-api/master-data/province", {
      headers: { "Token": API_TOKEN }
   });
   const data = await response.json();
   if (data.code === 200) {
      data.data.forEach(province => {
         const option = document.createElement("option");
         option.value = province.ProvinceID;
         option.textContent = province.ProvinceName;
         provinceSelect.appendChild(option);
      });
   }
}

// Tải danh sách quận/huyện
async function loadDistricts(provinceID) {
   districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện</option>';
   districtSelect.disabled = true;

   const response = await fetch("https://online-gateway.ghn.vn/shiip/public-api/master-data/district", {
      method: "POST",
      headers: { "Content-Type": "application/json", "Token": API_TOKEN },
      body: JSON.stringify({ province_id: parseInt(provinceID) })
   });
   
   const data = await response.json();
   if (data.code === 200) {
      data.data.forEach(district => {
         const option = document.createElement("option");
         option.value = district.DistrictID;
         option.textContent = district.DistrictName;
         districtSelect.appendChild(option);
      });
      districtSelect.disabled = false;
   }
}

// Tải danh sách phường/xã
async function loadWards(districtID) {
   wardSelect.innerHTML = '<option value="">Chọn Phường/Xã</option>';
   wardSelect.disabled = true;

   const response = await fetch("https://online-gateway.ghn.vn/shiip/public-api/master-data/ward", {
      method: "POST",
      headers: { "Content-Type": "application/json", "Token": API_TOKEN },
      body: JSON.stringify({ district_id: parseInt(districtID) })
   });

   const data = await response.json();
   if (data.code === 200) {
      data.data.forEach(ward => {
         const option = document.createElement("option");
         option.value = ward.WardCode;
         option.textContent = ward.WardName;
         wardSelect.appendChild(option);
      });
      wardSelect.disabled = false;
   }
}

// Lấy service_id hợp lệ
async function getValidServiceId(fromDistrict, toDistrict) {
   const response = await fetch("https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/available-services", {
      method: "POST",
      headers: { "Content-Type": "application/json", "Token": API_TOKEN },
      body: JSON.stringify({ shop_id: SHOP_ID, from_district: fromDistrict, to_district: toDistrict })
   });
   
   const data = await response.json();
   return data.code === 200 && data.data.length > 0 ? data.data[0].service_id : null;
}

// Tính phí vận chuyển
async function calculateShippingFee() {
   const toDistrict = districtSelect.value;
   const weight = parseInt(weightInput.value) || 0;

   if (!toDistrict) {
      shippingFeeInput.textContent = "Vui lòng chọn Quận/Huyện";
      return;
   }

   const serviceId = await getValidServiceId(1542, parseInt(toDistrict));
   if (!serviceId) {
      shippingFeeInput.textContent = "Không có dịch vụ GHN cho tuyến này";
      return;
   }

   const response = await fetch("https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee", {
      method: "POST",
      headers: { "Content-Type": "application/json", "Token": API_TOKEN },
      body: JSON.stringify({
         shop_id: SHOP_ID,
         from_district_id: 1542,
         to_district_id: parseInt(toDistrict),
         service_id: serviceId,
         weight: weight
      })
   });

   const data = await response.json();

   if (data.code === 200) {
      shippingFeeInput.textContent = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(data.data.total);
      paymentButton.classList.remove("disabled");
   } else {
      shippingFeeInput.textContent = "Tuyến đường chưa được hỗ trợ !!!";
      paymentButton.classList.add("disabled");
   }
   updateFinalTotal();
}

// Cập nhật tổng tiền
function updateFinalTotal() {
   const totalElement = document.getElementById("total");
   const finalTotalElement = document.getElementById("finalTotal");
   
   let totalPrice = Number(totalElement.value.replace(/\D/g, "")) || 0;
   let shippingPrice = Number(shippingFeeInput.textContent.replace(/\D/g, "")) || 0;
   
   finalTotalElement.value = new Intl.NumberFormat("vi-VN", { style: "currency", currency: "VND" }).format(totalPrice + shippingPrice);
}

// Cập nhật địa chỉ đầy đủ
function updateFullAddress() {
   const addressDetail = addressDetailInput.value.trim();
   const ward = wardSelect.selectedOptions[0]?.textContent || "";
   const district = districtSelect.selectedOptions[0]?.textContent || "";
   const province = provinceSelect.selectedOptions[0]?.textContent || "";
   
   address.value = [addressDetail, ward, district, province].filter(Boolean).join(", ");
}

// Sự kiện
provinceSelect.addEventListener("change", () => provinceSelect.value ? loadDistricts(provinceSelect.value) : districtSelect.disabled = true);
districtSelect.addEventListener("change", () => districtSelect.value ? loadWards(districtSelect.value) : wardSelect.disabled = true);
wardSelect.addEventListener("change", calculateShippingFee);
weightInput.addEventListener("input", calculateShippingFee);

["addressDetail", "ward", "district", "province"].forEach(id => {
   document.getElementById(id).addEventListener("change", updateFullAddress);
});

document.getElementById("priceShipping").addEventListener("DOMSubtreeModified", updateFinalTotal);
document.addEventListener("DOMContentLoaded", loadProvinces);