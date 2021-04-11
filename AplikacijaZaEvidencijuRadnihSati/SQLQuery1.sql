--Kod importa tablice "Djelatnik" bitno je ozna?iti TimID kao INT, u protivnom ?e se prikazati kao NVARCHAR te ne?e biti mogu?e
--napraviti foreign key na IDTim

alter table Djelatnik
add foreign key (TipDjelatnikaID) references TipDjelatnika(IDTipDjelatnika)

alter table Djelatnik
add foreign key (TimID) references Tim(IDTim)

alter table Projekt
add foreign key (KlijentID) references Klijent(IDKlijent)
alter table Projekt
add foreign key (VoditeljProjektaID) references Djelatnik(IDDjelatnik)
alter table ProjektDjelatnik
add foreign key (ProjektID) references Projekt(IDProjekt)
alter table ProjektDjelatnik
add foreign key (DjelatnikID) references Djelatnik(IDDjelatnik)



create table DnevniIzvjestaj(
IDDnevniIzvjestaj int primary key identity,
Datum date,
IzvjestajStatus int,
DjelatnikID int foreign key references Djelatnik(IDDjelatnik)
)

create table IzvjestajStatus(
IDIzvjestajStatus int primary key identity,
Naziv nvarchar(255)
)




--Procedure
create proc GetDjelatnici
as
begin
	select * from Djelatnik
end
go


alter proc Predaj
(  
   @Datum date,  
   @ProjektDjelatnikID int,  
   @MjerenoVrijemeMinute int,
   @RadniSatiMinute int,  
   @PrekovremeniSatiMinute int,
   @DnevniIzvjestajID int
)
as
begin
	insert into ProjekUpisanoVrijeme values(@Datum,@ProjektDjelatnikID,@MjerenoVrijemeMinute,@RadniSatiMinute,@PrekovremeniSatiMinute,@DnevniIzvjestajID)
end
go

alter proc NoviDnevniIzvjestaj(
@Datum date,
@IzvjestajStatus int,
@DjelatnikID int,
@Naziv nvarchar(MAX),
@Komentar nvarchar(MAX),
@Identity int output
)
as
begin
insert into DnevniIzvjestaj values(@Datum,@DjelatnikID,@Naziv,@Komentar,@IzvjestajStatus)


select @Identity = Scope_Identity()
end
go

DECLARE @Identity INT;
EXEC NoviDnevniIzvjestaj @Datum = '15-09-2020', @IzvjestajStatus = 0, @DjelatnikID = 1, @Identity output; 
Select @Identity


alter proc Predaj
(   
   @ProjektDjelatnikID int,
   @RadniSati time,  
   @PrekovremeniSati time,
   @DnevniIzvjestajID int
)
as
begin
	insert into ProjektUpisanoVrijeme values(@ProjektDjelatnikID,@RadniSati,@PrekovremeniSati,@DnevniIzvjestajID)
end
go


create proc GetDnevniIzvjestaj
(   
   @DjelatnikID int
)
as
begin
	select * from DnevniIzvjestaj where DjelatnikID = @DjelatnikID
end
go


delete from DnevniIzvjestaj
select * from TipDjelatnika
exec GetDnevniIzvjestaj @DjelatnikID = 4

alter proc GetProjektDjelatnik
@IDDjelatnik int
as
begin
	select IDProjektDjelatnik, ProjektID, DjelatnikID, Projekt.Naziv as 'NazivProjekta' from ProjektDjelatnik
	inner join Projekt on ProjektDjelatnik.ProjektID = Projekt.IDProjekt
	 Where DjelatnikID = @IDDjelatnik
end
go


select * from Djelatnik
exec PromijeniZaporku 'nbabic@ingenii.hr', 'OY273H0CPP','test123'

Create Proc PromijeniZaporku
@Email nvarchar(50),
@CurrentPassword nvarchar(50),
@NewPassword nvarchar(50)
as
Begin
 if(Exists(Select IDDjelatnik from Djelatnik 
    where Email = @Email
    and [Zaporka] = @CurrentPassword))
 Begin
  Update Djelatnik
  Set [Zaporka] = @NewPassword
  where Email = @Email
  
  Select 1 as IsPasswordChanged
 End
 Else
 Begin
  Select 0 as IsPasswordChanged
 End
End


Alter PROCEDURE LoginDjelatnici
      @Email NVARCHAR(20),
      @Password NVARCHAR(20)
AS
BEGIN
      SET NOCOUNT ON;
      DECLARE @UserID INT

      SELECT @UserId = IDDjelatnik
      FROM Djelatnik WHERE Email = @Email AND [Zaporka] = @Password
     
      IF @UserId IS NOT NULL
      BEGIN
      SELECT * FROM Djelatnik
	  WHERE Email = @Email AND [Zaporka] = @Password -- User Valid
      END
      ELSE
      BEGIN
            SELECT -1 -- User invalid.
      END
END

CREATE TABLE ProjektUpisanoVrijeme (
    IDProjektUpisanoVrijeme int primary key,
	Vrijeme datetime,
	ProjektDjelatnikID int foreign key references ProjektDjelatnik(IDProjektDjelatnik),
	MjerenoVrijemeMinute int,
	RadniSatiMinute int,
	PrekovremeniSatiMinute int
); 

alter table DnevniIzvjestaj
add Predano binary

add DnevniIzvjestajID int foreign key references DnevniIzvjestaj(IDDnevniIzvjestaj)

alter table ProjektUpisanoVrijeme
add DnevniIzvjestajID int foreign key references DnevniIzvjestaj(IDDnevniIzvjestaj)


alter table DnevniIzvjestaj
add Naziv nvarchar(200)

alter table DnevniIzvjestaj
add IzvjestajStatus int foreign key references IzvjestajStatus(IDIzvjestajStatus)
drop column IzvjestajStatus


CREATE TABLE DnevniIzvjestaj (
    IDDnevniIzvjestaj int primary key,
	Datum date,
	IzvjestajStatus int,
	Komentar nvarchar(max),
	PrekovremeniSatiMinute int
); 

CREATE TABLE ProjektUpisanoVrijeme (
    IDProjektUpisanoVrijeme int primary key identity,
	ProjektDjelatnikID int foreign key references ProjektDjelatnik(IDProjektDjelatnik),
	RadniSati time,
	PrekovremeniSati time,
	Komentar nvarchar(max),
	DnevniIzvjestajID int foreign key references DnevniIzvjestaj(IDDnevniIzvjestaj)
);

ALTER PROCEDURE PrikazDetalja @Id int
as
select DnevniIzvjestaj.Datum, DnevniIzvjestaj.IzvjestajStatus, DnevniIzvjestaj.Naziv, DnevniIzvjestaj.Komentar, ProjektUpisanoVrijeme.RadniSati, ProjektUpisanoVrijeme.PrekovremeniSati, Projekt.Naziv as 'ProjektNaziv' from DnevniIzvjestaj
inner join ProjektUpisanoVrijeme on ProjektUpisanoVrijeme.DnevniIzvjestajID = DnevniIzvjestaj.IDDnevniIzvjestaj
inner join ProjektDjelatnik on ProjektDjelatnik.IDProjektDjelatnik = ProjektUpisanoVrijeme.ProjektDjelatnikID
inner join Projekt on Projekt.IDProjekt = ProjektDjelatnik.ProjektID
where DnevniIzvjestaj.IDDnevniIzvjestaj = @Id
GO

ALTER PROCEDURE PrikazTimskihDetalja @TimId int, @DjelatnikID int
as
select DnevniIzvjestaj.Datum, DnevniIzvjestaj.IzvjestajStatus, DnevniIzvjestaj.Naziv, DnevniIzvjestaj.Komentar, ProjektUpisanoVrijeme.RadniSati, ProjektUpisanoVrijeme.PrekovremeniSati, Projekt.Naziv as 'ProjektNaziv', Djelatnik.TimID from DnevniIzvjestaj
inner join ProjektUpisanoVrijeme on ProjektUpisanoVrijeme.DnevniIzvjestajID = DnevniIzvjestaj.IDDnevniIzvjestaj
inner join ProjektDjelatnik on ProjektDjelatnik.IDProjektDjelatnik = ProjektUpisanoVrijeme.ProjektDjelatnikID
inner join Projekt on Projekt.IDProjekt = ProjektDjelatnik.ProjektID
inner join Djelatnik on Djelatnik.IDDjelatnik = DnevniIzvjestaj.DjelatnikID

where Djelatnik.TimID = @TimId AND Djelatnik.IDDjelatnik = @DjelatnikID
GO

alter proc GetDjelatnici @TimID int
as
Select IDDjelatnik, Ime + ' ' + Prezime as 'Djelatnik', Email, DatumZaposlenja,Zaporka, TipDjelatnika.Naziv, Tim.Naziv from Djelatnik
inner join TipDjelatnika on TipDjelatnika.IDTipDjelatnika = Djelatnik.TipDjelatnikaID
inner join Tim on Tim.IDTim = Djelatnik.TimID
where Tim.IDTim = @TimID

select * from DnevniIzvjestaj

select * From IzvjestajStatus

insert into IzvjestajStatus(Naziv)
VALUES('Na pregledu'),('Odobren'),('Vraćen na doradu')


delete from ProjektUpisanoVrijeme

delete from DnevniIzvjestaj where IDDnevniIzvjestaj = 1041

create proc Odobri @IDIzvjestaj int
as
update DnevniIzvjestaj
Set IzvjestajStatus = 2
where DnevniIzvjestaj.IDDnevniIzvjestaj = @IDIzvjestaj

exec Odobri @IDIzvjestaj = 1040

alter proc VratiNaDoradu @IDIzvjestaj int
as
update DnevniIzvjestaj
set IzvjestajStatus = 3
where DnevniIzvjestaj.IDDnevniIzvjestaj = @IDIzvjestaj

exec VratiNaDoradu 1040

create proc PromijeniTimDjelatnika @TimID int, @IDDjelatnik int
as
Update Djelatnik
set TimID = @TimID
where Djelatnik.IDDjelatnik = @IDDjelatnik


exec PromijeniTimDjelatnika 2, 11
select * from TipDjelatnika
select * from Projekt
where Djelatnik.TipDjelatnikaID = 1

select * from ProjektDjelatnik
where DjelatnikID = 8

create proc DjelatniciNaProjektu @IDProjekt int
as
select Djelatnik.Ime +' '+Djelatnik.Prezime as 'Djelatnik' from ProjektDjelatnik
inner join Djelatnik on Djelatnik.IDDjelatnik = ProjektDjelatnik.DjelatnikID
where ProjektDjelatnik.ProjektID = @IDProjekt

create proc PrikazProjekata @UserID int
as
select Projekt.Naziv, Klijent.Naziv, Projekt.DatumOtvaranja from Projekt
inner join Klijent on Klijent.IDKlijent = Projekt.KlijentID
where Projekt.VoditeljProjektaID = @UserID

create proc DodajDjelatnikaNaProjekt @DjelatnikID int, @ProjektID int
as
insert into ProjektDjelatnik(ProjektID,DjelatnikID)
values(@DjelatnikID,@ProjektID)

alter proc SelectDostupnihDjelatnika @ProjektID int
as
select distinct Djelatnik.IDDjelatnik, Djelatnik.Ime + ' ' + Djelatnik.Prezime as 'Djelatnik' from Djelatnik
inner join ProjektDjelatnik on Djelatnik.IDDjelatnik = ProjektDjelatnik.DjelatnikID
where IDDjelatnik NOT IN (
select DjelatnikID from ProjektDjelatnik
where ProjektDjelatnik.ProjektID = @ProjektID
)  AND Djelatnik.TipDjelatnikaID <> 2 AND Djelatnik.TipDjelatnikaID <> 1


exec SelectDostupnihDjelatnika 1
select * from TipDjelatnika
select * from DnevniIzvjestaj 4
exec GetDnevniIzvjestaj 4
exec PrikazDetalja 1042
select * from ProjektDjelatnik
where ProjektID = 2

create proc Ispravi
(   
   @ProjektDjelatnikID int,
   @RadniSati time,  
   @PrekovremeniSati time,
   @Komentar nvarchar(255)
)
as
begin
	update ProjektUpisanoVrijeme
	set RadniSati = @RadniSati, PrekovremeniSati = @PrekovremeniSati
	where ProjektUpisanoVrijeme.ProjektDjelatnikID = @ProjektDjelatnikID

	update DnevniIzvjestaj
	set Komentar = @Komentar
from DnevniIzvjestaj
inner join DnevniIzvjestaj on DnevniIzvjestaj.IDDnevniIzvjestaj = ProjektUpisanoVrijeme.DnevniIzvjestajID
    where ProjektUpisanoVrijeme.ProjektDjelatnikID = @ProjektDjelatnikID
end
go

select * from Djelatnik

create proc DodajDjelatnikaNaProjekt2 @DjelatnikID int, @ProjektID int
as
update ProjektDjelatnik
set ProjektID = @ProjektID
where DjelatnikID = @DjelatnikID

alter proc DohvatiUkupnoSatiZaKlijenta @IDKlijent int
as
select Projekt.Naziv as 'Naziv projekta', CONVERT(NUMERIC(18, 2), SUM(DATEDIFF(MINUTE, '0:00:00', ProjektUpisanoVrijeme.PrekovremeniSati)+DATEDIFF(MINUTE, '0:00:00', ProjektUpisanoVrijeme.RadniSati))/ 60 + (SUM(DATEDIFF(MINUTE, '0:00:00', ProjektUpisanoVrijeme.PrekovremeniSati)+DATEDIFF(MINUTE, '0:00:00', ProjektUpisanoVrijeme.RadniSati))% 60) / 100.0) as 'Ukupno vrijeme(HH:MM)' from Projekt
inner join ProjektDjelatnik on ProjektDjelatnik.ProjektID = Projekt.IDProjekt
inner join ProjektUpisanoVrijeme on ProjektUpisanoVrijeme.ProjektDjelatnikID = ProjektDjelatnik.IDProjektDjelatnik
inner join Klijent on Klijent.IDKlijent = Projekt.KlijentID
where Klijent.IDKlijent = @IDKlijent
group by Projekt.Naziv

select * from Projekt

select * from ProjektUpisanoVrijeme
inner join ProjektDjelatnik on ProjektDjelatnik.IDProjektDjelatnik = ProjektUpisanoVrijeme.ProjektDjelatnikID
where ProjektDjelatnik.ProjektID = 3

select * from DnevniIzvjestaj
select * from ProjektUpisanoVrijeme

exec PrikazDetalja 1044

select Djelatnik.Ime + ' ' + Djelatnik.Prezime as 'Djelatnik', TipDjelatnika.Naziv, DATEDIFF(MINUTE, '0:00:00', ProjektUpisanoVrijeme.RadniSati) as 'Radni sati', DATEDIFF(MINUTE, '0:00:00', ProjektUpisanoVrijeme.PrekovremeniSati) as 'Prekovremeni sati', (SUM(DATEDIFF(MINUTE, '0:00:00', ProjektUpisanoVrijeme.PrekovremeniSati)+DATEDIFF(MINUTE, '0:00:00', ProjektUpisanoVrijeme.RadniSati))/ 60 + (SUM(DATEDIFF(MINUTE, '0:00:00', ProjektUpisanoVrijeme.PrekovremeniSati)+DATEDIFF(MINUTE, '0:00:00', ProjektUpisanoVrijeme.RadniSati))% 60) / 100.0) as 'Ukupno vrijeme(HH:MM)'
from Djelatnik
inner join TipDjelatnika on TipDjelatnika.IDTipDjelatnika = Djelatnik.IDDjelatnik
inner join ProjektDjelatnik on ProjektDjelatnik.DjelatnikID = Djelatnik.IDDjelatnik
inner join ProjektUpisanoVrijeme on ProjektUpisanoVrijeme.ProjektDjelatnikID = ProjektDjelatnik.IDProjektDjelatnik
group by Djelatnik.Ime + ' ' + Djelatnik.Prezime, TipDjelatnika.Naziv, RadniSati, PrekovremeniSati