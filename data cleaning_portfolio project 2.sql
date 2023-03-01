 --Breaking Out Address into individuals columns (address, city, state)
 --Owner Address
  select *
 from NashvilleHousing
 
  
 select 
 split_part(owneraddress::text,',',1) as address,
 split_part(owneraddress::text,',',-2) as city,
 split_part(owneraddress::text,',',-1) as state
 from NashvilleHousing 
 
 alter table  NashvilleHousing
 add owner_address nchar(100)
 
 update  NashvilleHousing
 set owner_address =split_part(owneraddress::text,',',1)
 
 alter table  NashvilleHousing
 add  ownercity nchar(100)
 
 update  NashvilleHousing
 set ownercity = split_part(owneraddress::text,',',-2)
 
 alter table  NashvilleHousing
 add ownerstate nchar(100)
 
 update  NashvilleHousing
 set ownerstate =split_part(owneraddress::text,',',-1)
 
  select *
 from NashvilleHousing
 order by parcelid
 
-- change Y and N to Yes and No in "soldasvacant" column

select distinct (soldasvacant),count(soldasvacant)
from NashvilleHousing
group by soldasvacant
order by soldasvacant

select soldasvacant,
case when soldasvacant = 'Y' then 'Yes'
     when soldasvacant = 'N' then 'No'
	 else soldasvacant
end
from NashvilleHousing

update NashvilleHousing
set soldasvacant = case when soldasvacant = 'Y' then 'Yes'
                        when soldasvacant = 'N' then 'No'
	                    else soldasvacant
                   end
                   
select distinct (soldasvacant)
from NashvilleHousing
group by soldasvacant
order by soldasvacant 
 
 -- Remove duplicates
select *,
        row_number() over (
			partition by parcelid,
		                 propertyaddress,
		                 saleprice,
		                 saledate,
		                 legalreference
		   order by uniqueid) as row_num
from NashvilleHousing
--order by parcelid

delete from NashvilleHousing
where uniqueid in
       (select uniqueid
	   from 
            (select *,
             row_number() over (
			partition by parcelid,
		                 propertyaddress,
		                 saleprice,
		                 saledate,
		                 legalreference
		   order by uniqueid) as row_num
         from NashvilleHousing) t
		 where t.row_num > 1)

select * 
from NashvilleHousing

-- Delete unused columns
alter table NashvilleHousing
drop column OwnerAddress, 
drop column PropertyAddress,
drop column TaxDistrict

