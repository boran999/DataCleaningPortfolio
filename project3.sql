






select SaleDate_ convert(Date, SaleDate)
from project.BrooklynHousing

update BrooklynHousing
set SaleDate = convert(Date, SaleDate)

alter table BrooklynHousing 
add SaleDate_ date;



update BrooklynHousing
set SaleDate_ = convert(Date, SaleDate)


--------------------------------------------------------------------------------------


select * from BrooklynHousing
--where PropertyAdress is null
order by ParcelID





select a.ParcelID, a.PropertyAddress, b.ParcelAddress, b.PropertyAddress isnull( a.PropertyAddress,  b.PropertyAddress)
from BrooklynHousing a
join BrooklynHousing b
on a.ParcelID = b.ParcelID
and [a.UniqueID] <> [b.UniqueID]
where a.PropertyAddress is null 


Update a 
set PropertyAddress = isnull( a.PropertyAddress,  b.PropertyAddress)
from BrooklynHousing a
join BrooklynHousing b
on a.ParcelID = b.ParcelID
and [a.UniqueID] <> [b.UniqueID] 
where a.PropertyAddress is null 

-----------------------------------------------------------------------------------------------


select PropertyAddress
from BrooklynHousing
--where PropertyAdress is null
--order by ParcelID


select
SUBSTRING(PropertyAdress, 1, CHARINDEX(',', PropertyAddress) -1 ) as address,
 SUBSTRING(PropertyAdress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) as address
from BrooklynHousing

alter table BrooklynHousing 
add Address_ nvarchar(100);



update BrooklynHousing
set Address_ = SUBSTRING(PropertyAdress, 1, CHARINDEX(',', PropertyAddress) -1 )


alter table BrooklynHousing 
add city_ nvarchar(100);



update BrooklynHousing
set city_ = SUBSTRING(PropertyAdress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))

select *
from BrooklynHousing

--------------------------------------------------------------------------------------------------------------


select OwnerAddress
from BrooklynHousing


select
parsename(replace (OwnerAddress, ',', '.') , 3) 
,parsename(replace (OwnerAddress, ',', '.') , 2) 
,parsename(replace (OwnerAddress, ',', '.') , 1) 
from BrooklynHousing



alter table BrooklynHousing 
add OwnerAddress_ nvarchar(100);



update BrooklynHousing
set OwnerAddress_ = parsename(replace (OwnerAddress, ',', '.') , 3) 


alter table BrooklynHousing 
add Ownercity_ nvarchar(100);



update BrooklynHousing
set Ownercity_ = parsename(replace (OwnerAddress, ',', '.') , 2) 

alter table BrooklynHousing 
add OwnerSplitState nvarchar(100);



update BrooklynHousing
set OwnerSplitState = parsename(replace (OwnerAddress, ',', '.') , 1) 

--------------------------------------------------------------------------------------------------------------



select distinct (SoldASVacant), Count(SoldASVacant)
from BrooklynHousing
group by SoldASVacant
order by 2















select SoldASVacant 
, Case when SoldASVacant = 'Y' then 'yes'
       when SoldASVacant = 'N' then 'no'
	   else SoldASVacant 
	   End
from BrooklynHousing

Update BrooklynHousing
set SoldASVacant = Case when SoldASVacant = 'Y' then 'yes'
       when SoldASVacant = 'N' then 'no'
	   else SoldASVacant 
	   End


	   ------------------------------------------------------------------------------






With RowNumCTE as(
select *,
	Row_Number() over (
	Partition by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReferance
				 Order by UniqueID
				 ) row_num	
			
from BrooklynHousing
order by ParcelID
)
delete from RowNumCTE
where row_num > 1 
--Order by PropertyAddress





Alter table BrooklynHousing
drop column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
