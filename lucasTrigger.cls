public class surpriseGift {
	
    public static Contact forMyLove(string name, string lastName, date birthdate) {
        contact LucasConde = New contact (
        FirstName = name,
        LastName = lastName,
        Birthdate = birthdate);
        
        insert LucasConde;
        return LucasConde;
    }

    trigger surpriseGift on Contact (before insert, before update) {
    
    for (Contact c: Trigger.New){
        if (c.FirstName == 'Lucas' && c.LastName == 'Conde' && (c.Birthdate.addYears(23) == date.today())) {
            c.FirstName = 'Senior' + ' ' + c.FirstName;
            c.Description = '¡¡¡Feliz Cumple Miamor !!! ♥♥♥♥ Te Amu ! ♥♥♥♥';

        }
    }

}

}