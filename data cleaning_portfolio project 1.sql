CREATE TABLE NashvilleHousing
(
  UniqueID nchar(50),
  ParcelID nchar(50),
  LandUse varchar(100),
  PropertyAddress varchar(100),
  SaleDate date,
  SalePrice varchar(250),
  LegalReference varchar(250),
  SoldAsVacant varchar(100),
  OwnerName varchar(100),
  OwnerAddress varchar(100),
  Acreage float,
  TaxDistrict varchar(100),
  LandValue numeric,
  BuildingValue numeric,
  TotalValue numeric,
  YearBuilt int,
  Bedrooms numeric,
  FullBath numeric,
  HalfBath numeric
)
copy NashvilleHousing from 'C:\Users\owner\Downloads\NashvilleHousing.csv' with csv header;

select *
from NashvilleHousing

--populate property address data

select *
from NashvilleHousing
--where propertyaddress is null
order by parcelid

select ab.parcelid,ab.propertyaddress,cd.parcelid,cd.propertyaddress, coalesce (ab.propertyaddress,cd.propertyaddress)
from NashvilleHousing as ab
  join NashvilleHousing as cd
  on ab.parcelid = cd.parcelid
  and ab.uniqueid <> cd.uniqueid
 where ab.propertyaddress is null
 
 update NashvilleHousing
 set propertyaddress = coalesce (ab.propertyaddress,cd.propertyaddress)
 from NashvilleHousing as ab
  join NashvilleHousing as cd
  on ab.parcelid = cd.parcelid
  and ab.uniqueid <> cd.uniqueid
 where ab.propertyaddress is null
 and ab = NashvilleHousing
 
 select*
 from NashvilleHousing
 
 --Breaking Out Address into individuals columns (address, city, state)
 --Property Address
 select propertyaddress
 from NashvilleHousing 
 
 select 
 split_part(propertyaddress::text,',',1) as address,
 split_part(propertyaddress::text,',',-1) as city
 from NashvilleHousing 
 
 alter table  NashvilleHousing
 add property_address nchar(100)
 
 update  NashvilleHousing
 set property_address =split_part(propertyaddress::text,',',1)
 
 alter table  NashvilleHousing
 add  propertycity nchar(100)
 
 update  NashvilleHousing
 set propertycity = split_part(propertyaddress::text,',',-1)
 
 --Owner Address
  select propertyaddress
 from NashvilleHousing
 
 